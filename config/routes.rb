Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :posts, only: :index
  resources :questions, only: %i(new)
  resources :resources, only: %i(new create) do
    collection do
      post :preview
    end
  end
end
