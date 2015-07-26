Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :resources, only: %i(index new create) do
    collection do
      post :preview
    end
  end
end
