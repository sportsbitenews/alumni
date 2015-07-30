class UsersController < ApplicationController
  def show
    @user = User.where('lower(github_nickname) = ?', params[:github_nickname].downcase).first
    if @user
      authorize @user
      if params[:github_nickname] != @user.github_nickname
        redirect_to user_path(@user.github_nickname)
      end
    else
      not_found
    end
  end
end
