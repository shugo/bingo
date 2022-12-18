Rails.application.routes.draw do
  namespace :admin do
    resources :numbers, only: [:index, :create]
    delete "/numbers", to: "numbers#destroy"

    root "numbers#index"
  end
  resources :numbers, only: [:index]
  resource :card, only: [:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "card#show"
end
