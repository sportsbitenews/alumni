class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.find_for_github_oauth(request.env["omniauth.auth"])
    omniauth_params = request.env["omniauth.params"]
    if omniauth_params.has_key? "batch"
      batch = Batch.find(omniauth_params['batch'])
      if batch.onboarding
        @user.alumni = false
        @user.save!
        sign_in @user, :event => :authentication
        redirect_to register_batch_path(batch)
      else
        flash[:alert] = "The registration period is over for this batch."
        redirect_to root_path
      end
    elsif true
      # TODO : check if user is in the alumni list.
      # @user.alumni = true
      if @user.persisted? || @user.valid?
        @user.save
        sign_in @user, :event => :authentication
        redirect_to after_sign_in
      else
        flash[:alert] = @user.errors.messages.values.join(", ")
        redirect_to root_path
      end
    else
      flash[:alert] = "The platform is reserved to the alumni."
      redirect_to root_path
    end
  end

  private

  def after_sign_in
    query = URI.parse(request.env['omniauth.origin']).query
    return_to = CGI.parse(query)["return_to"].first if query
    if return_to.blank?
      if request.env['omniauth.origin'].blank?
        root_path
      else
        request.env['omniauth.origin']
      end
    else
      return_to
    end
  rescue
    root_path
  end
end
