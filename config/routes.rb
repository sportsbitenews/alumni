Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'posts#index'

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :posts, only: %i(index  ) do
    member do
      post :up_vote
    end
  end

  resources :answers, only: [:create] do
    collection do
      post :preview
    end
  end
  resources :batches, only: %i(show edit update)
  resources :questions, only: %i(new show create)
  resources :milestones, only: %i(new show create)
  resources :jobs, only: %i(new show create)
  resources :resources, only: %i(new create show) do
    collection do
      post :preview
    end
  end
  resources :cities, only: %i(index show) do
    resources :batches, only: %i(new create)
  end

  resources :users, only: %i(index)

  get '/:github_nickname', to: 'users#show', as: :profile
end
