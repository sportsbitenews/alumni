class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.find_for_github_oauth(request.env["omniauth.auth"])
    omniauth_params = request.env["omniauth.params"]
    if omniauth_params.has_key? "batch"
      batch = Batch.find(omniauth_params['batch'])
      if batch.onboarding
        if @user.alumni
          sign_in @user, :event => :authentication
          flash[:notice] = "Welcome to the Alumni :) Start browsing these resources"
          redirect_to root_path
        elsif @user.teacher || @user.staff || @user.admin
          sign_in @user, :event => :authentication
          flash[:alert] = "You cannot onboard a Batch, you're Staff! ;)"
          redirect_to root_path
        else
          @user.alumni = false
          @user.batch = batch
          @user.save!
          sign_in @user, :event => :authentication
          redirect_to register_batch_path(batch)
        end
      else
        flash[:alert] = "The registration period is over for this batch."
        redirect_to root_path
      end
    elsif omniauth_params['scenario'] === 'upvote'
      @user.save!
      sign_in @user, :event => :authentication
      @user.up_votes omniauth_params['post_type'].constantize.find(omniauth_params['post_id'])
      redirect_to after_sign_in
    elsif omniauth_params['scenario'] == 'post_answer'
      @user.save!
      sign_in @user, :event => :authentication
      answer = @user.answers.create content: omniauth_params['content']
      omniauth_params['post_type'].constantize.find(omniauth_params['post_id']).answers << answer
      redirect_to eval(omniauth_params["post_type"].downcase + "_path(omniauth_params['post_id'])")
    elsif @user.persisted? && @user.legit?
      @user.save
      sign_in @user, :event => :authentication
      redirect_to after_sign_in
    else
      flash[:alert] = "Sorry, this website is reserved to the Wagon alumni."
      redirect_to new_user_session_path
    end
  end

  def slack
    if params[:error].blank?
      auth = request.env["omniauth.auth"]
      if current_user.update(slack_uid: auth["uid"], slack_token: auth["credentials"]["token"])
        flash[:notice] = "Awesome! Your Slack account is now linked"
      else
        flash[:error] = "There was an issue while linking your Slack account. Ask @ssaunier."
      end
    end
    redirect_to root_path
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
