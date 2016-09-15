class CityAdmin::UsersController < ApplicationController
  def update
    @ordered_list_id = params[:ordered_list_id]
    @user = User.find_by_slug(params[:id])
    authorize @user, :admin_update?
    @user.update(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:role, :twitter_nickname, :bio_en, :bio_fr, :photo)
  end
end

