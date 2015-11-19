class Api::V1::UsersController < Api::V1::BaseController
  before_action :check_shared_secret!

  def picture
    # ssaunier__sebastien_jean_marie_christian_saunier.jpg
    github_nickname = params[:filename].split("__").first
    user = User.find_by_github_nickname(github_nickname)
    if user
      f = Tempfile.new([ params[:filename], '.jpg' ])
      f.binmode
      f.write(Base64.decode64 params[:content])
      f.rewind
      f.close
      user.picture = File.open(f.path)
      user.save
      f.unlink
      render json: { found: true, user: { id: user.id, github_nickname: user.github_nickname, }}
    else
      render json: { found: false }
    end
  end

  private

  def check_shared_secret!
    fail HttpAuthorizationHeaderException if request.headers['HTTP_AUTHORIZATION'] != ENV.fetch('ALUMNI_PICTURE_UPLOADER_SCRIPT_SHARED_SECRET')
  end
end
