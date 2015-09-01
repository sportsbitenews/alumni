# https://github.com/railsware/js-routes#advanced-setup
JsRoutes.setup do |config|
  # Whitelist routes to include on the Front-End
  # NOTE(ssaunier): if you add a new route here, do not forget to run:
  #                 $ rake tmp:cache:clear
  #                 before restarting your `rails s`.
  config.include = [
    /resource/,
    /question/,
    /^jobs$/,
    /^job$/,
    /^new_job$/,
    /^milestones$/,
    /^milestone$/,
    /^new_milestone$/,

    /up_vote/,

    /^users$/,
    /^profile$/,
    /^destroy_user_session$/,

    /^preview_answers$/,
    /^answers$/,

    /^batch$/,
    /^project$/,

    /^confirm_user$/,
    /^delete_user$/
  ]
end
