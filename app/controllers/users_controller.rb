class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  skip_after_action :verify_authorized, only: :show

  before_action :set_user, only: %i(update confirm delete update_profile)
  def index
    @users = policy_scope(User).includes(:batch).where.not(last_name: nil).order(:last_name)
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
        @user = User.includes(:batch).where('lower(github_nickname) = ?', params[:github_nickname].downcase).first
        @projects = @user.projects.order(created_at: :desc)
        if @user
          if params[:github_nickname] != @user.github_nickname
            redirect_to profile_path(@user.github_nickname)
          end
          if @user.pre_wagon_experiences.nil?
            @pre_experiences = []
          else
            @pre_experiences = @user.pre_wagon_experiences
          end
          if @user.pre_wagon_experiences.nil?
            @post_experiences = []
          else
            @post_experiences = @user.post_wagon_experiences
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

  def update_profile
    @user.update_attributes(user_params)
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
    @user = User.includes(:batch).find(params[:id])
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
      :mood
    )
  end
end
