class CityAdmin::UsersController < ApplicationController
  def update
    @user = User.find_by_slug(params[:id])
    authorize @user, :admin_update?
    photo = user_params[:photo]
    user_params_without_photo = user_params.except(:photo)
    @user.update(user_params_without_photo)
    unless photo.blank?
      @user.photo = photo
    end
  end

  private

  def user_params
    params.require(:user).permit(:role, :twitter_nickname, :bio_en, :bio_fr, :photo)
  end
end

