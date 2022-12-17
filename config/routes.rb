Rails.application.routes.draw do
  resources :numbers, only: [:index, :create]
  get "/numbers/selected", to: "numbers#selected"
  delete "/numbers", to: "numbers#destroy"
  resource :card, only: [:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "card#show"
end
