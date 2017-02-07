RailsAdmin.config do |config|
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.authorize_with do |controller|
    redirect_to main_app.root_path unless current_user.admin
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show

    config.model 'Batch' do
      list do
        field :slug
        field :city
        field :starts_at
        field :onboarding
        field :open_for_registration
        field :slack_id
      end
    end

    config.model 'User' do
      list do
        field :id
        field :github_nickname
        field :first_name
        field :last_name
        field :last_sign_in_at
        field :batch
      end
    end

    config.model 'City' do
      list do
        field :id
        field :slug
        field :location
        field :address
        field :city_picture
      end
    end
  end
end
