Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Attachinary::Engine => "/attachinary"
  root 'posts#index'

  # API routing
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resource :statistics,    only: :show
      resources :cities,       only: [ :index, :show ] do
        collection do
          get "slugs"
        end
      end
      resources :city_groups,  only: [ :index ]
      resources :batches,      only: [ :show ] do
        collection do
          get "live"
          get "completed"
        end
      end
      resources :projects,     only: [ :index, :update ] do
        collection do
          post "positions"
        end
      end
      resources :alumni,       only: [ :index ]
      resources :staff,        only: [ :index ]
      resources :stories,      only: [ :index, :show ] do
        collection do
          get "sample"
        end
      end
      resources :testimonials, only: [ :index ]
      resources :users,        only: [] do
        put :picture, on: :collection
      end
      resources :positions, only: [ :index ]
    end
  end

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :posts, only: %i(index) do
    member do
      post :up_vote
    end
    collection do
      get :next
      post :search
    end
  end

  resources :answers, only: [:create, :update, :destroy] do
    collection do
      post :preview
      get :language
    end
  end

  resources :batches, only: %i(show edit update) do
    member do
      get :register
      get :signing_sheet
      patch :signing_sheet
    end
  end

  get :onboarding, to: 'batches#onboarding'

  resources :questions, only: %i(new show create update) do
    member do
      patch :solve
    end
  end
  resources :milestones, only: %i(new show create update)
  resources :jobs, only: %i(new show create update)
  resources :projects, only: %i(show)
  resources :resources, only: %i(new create show) do
    collection do
      post :preview
    end
  end
  resources :cities, only: %i(index show edit update) do
    collection do
      get :markdown_preview
    end
    member do
      post :set_manager
    end
    resources :batches, only: %i(new create)
  end
  resources :ordered_lists, only: :update

  resources :users, only: %i(index update) do
    member do
      post :confirm
      post :delete
      post :offboard
      patch :update_photo
    end
  end
  get '/offboarding',                  to: 'users#offboarding'
  get '/offboarding/:github_nickname', to: 'users#offboarding'

  resources :testimonials, only: [:create, :update]

  namespace :city_admin do
    resources :users, only: %i(update)
  end

  post 'slack/interactive_message', to: 'slack#interactive_message'

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  get '/impersonate/:id', to: 'users#impersonate'
  get '/stop_impersonating', to: 'users#stop_impersonating', as: :stop_impersonating

  # Keep this route at the bottom.
  get '/:github_nickname', as: :profile, to: 'users#show' #, to: redirect { |params, _| "https://kitt.lewagon.com/alumni/#{params[:github_nickname]}" }
end
