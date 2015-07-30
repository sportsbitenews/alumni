Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :posts, only: %i(index) do
    member do
      post :up_vote
    end
  end
  resources :questions, only: %i(new show)
  resources :resources, only: %i(new create show) do
    collection do
      post :preview
    end
  end
end
