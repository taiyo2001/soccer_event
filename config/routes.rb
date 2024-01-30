Rails.application.routes.draw do
  resources :teams, only: [:show]
  resources :leagues, only: %i[index show]
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users, only: %i[index show]
  resources :team_comments, only: %i[create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'
end
