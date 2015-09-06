class UsersController < ApplicationController
  before_action :set_user, only: %i(update confirm delete)
  def index
    ids = params[:ids] || []
    @users = policy_scope(User).where(id: ids.map(&:to_i))
  end

  def show
    respond_to do |format|
      format.html do
        @user = User.where('lower(github_nickname) = ?', params[:github_nickname].downcase).first
        if @user
          authorize @user
          if params[:github_nickname] != @user.github_nickname
            redirect_to profile_path(@user.github_nickname)
          end
        else
          not_found
        end
      end
    end
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to root_path
    else
      # TODO: handle error
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
      :school
    )
  end
end
