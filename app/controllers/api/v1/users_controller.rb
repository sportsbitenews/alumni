class Api::V1::UsersController < Api::V1::BaseController
  before_action :check_shared_secret!

  class HttpAuthorizationHeaderException < Exception; end

  def picture
    # ssaunier__sebastien_jean_marie_christian_saunier.jpg
    github_nickname = params[:filename].split("__").first
    user = User.where('github_nickname ILIKE ?', github_nickname).first
    if user
      f = Tempfile.new([ params[:filename], '.jpg' ])
      f.binmode
      f.write(Base64.decode64 params[:content])
      f.rewind
      f.close
      user.photo = File.open(f.path)
      user.save
      f.unlink
      render json: { found: true, user: { id: user.id, github_nickname: user.github_nickname, }}
    else
      render json: { found: false }
    end
  end

  def show
    @user = User.find_by_github_nickname(params[:id])
  end

  private

  def check_shared_secret!
    fail HttpAuthorizationHeaderException if request.headers['HTTP_AUTHORIZATION'] != ENV.fetch('ALUMNI_PICTURE_UPLOADER_SCRIPT_SHARED_SECRET')
  end
end
