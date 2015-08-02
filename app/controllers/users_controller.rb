class UsersController < ApplicationController
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
end
