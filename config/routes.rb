Rails.application.routes.draw do
  get "/", to:"searches#index"
  resources :searches, only: [:new, :create]
end
