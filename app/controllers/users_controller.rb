class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  skip_after_action :verify_authorized, only: %i(show)

  before_action :set_user, only: %i(update confirm delete)
  def index
    query = params[:query]
    if query.blank?
      @users = policy_scope(User).none
    else
      @users = policy_scope(User).where('github_nickname ILIKE ?', query + "%").select(:first_name, :last_name, :github_nickname)
    end
  end

  def show
    respond_to do |format|
      format.html do
        @user = User.where('lower(github_nickname) = ?', params[:github_nickname].downcase).first
        if @user
          if params[:github_nickname] != @user.github_nickname
            redirect_to profile_path(@user.github_nickname)
          end
        else
          render_404
        end
      end
      format.all { render_404 }
    end
  end

  def update
    @user.onboarding = true
    if @user.update_attributes(user_params)
      redirect_to root_path
    else
      render 'batches/register'
    end
  end

  def delete
    if @user.legit?
      @user.alumni = false
      @user.batch = nil
      @user.save
    else
      @user.destroy!
    end
    render nothing: true
  end

  def confirm
    unless @user.alumni # Stay idempotent to double clicks
      @user.alumni = true
      @user.save!
      OnboardUserJob.perform_later(@user.id)
    end
    render nothing: true
  end

  def impersonate
    authorize current_user
    user = User.where(id: params[:id]).first || User.where('lower(github_nickname) = ?', params[:id].downcase).first
    impersonate_user(user)
    redirect_to profile_path(user.github_nickname)
  end

  def stop_impersonating
    authorize true_user
    stop_impersonating_user
    redirect_to params[:return_to]
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :birth_day,
      :phone,
      :school,
      :private_bio,
      :batch_id
    )
  end
end
