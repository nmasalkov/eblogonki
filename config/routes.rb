Rails.application.routes.draw do

  resources :dashboard, only: [:index]

  get '/users/sign_up', to: "dashboard#index"

  resources :stakes

  root to: "dashboard#index"

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
