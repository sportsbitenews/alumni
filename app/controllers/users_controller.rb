class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  skip_after_action :verify_authorized, only: :show

  before_action :set_user, only: %i(update confirm delete)
  def index
    @users = policy_scope(User).includes(:batch).where.not("last_name=? AND last_name=?", nil, "").shuffle.first(20)
    # query = params[:query]
    # if query.blank?
    #   @users = policy_scope(User).none
    # else
    #   @users = policy_scope(User).where('github_nickname ILIKE ?', query + "%").select(:first_name, :last_name, :github_nickname)
    # end
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
    @user.destroy!
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
      :private_bio
    )
  end
end
