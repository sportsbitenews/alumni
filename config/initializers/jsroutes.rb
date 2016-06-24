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

    /^up_vote_post$/,
    /^search_posts$/,
    /^next_posts$/,

    /^stop_impersonating$/,
    /^users$/,
    /^profile$/,
    /^destroy_user_session$/,

    /^preview_answers$/,
    /^language_answers$/,
    /^answers$/,
    /^answer$/,

    /^batch$/,
    /^project$/,

    /^confirm_user$/,
    /^delete_user$/,
    /^solve_question$/,

    /^city$/,
    /^cities$/,
    /^markdown_preview_cities$/,
    /^set_manager_city$/,
    /^ordered_list$/,
    /^city_admin_user$/,

    /^testimonials$/,
    /^testimonial$/
  ]
end
