Rails.application.routes.draw do
  resources :teams, only: [:show]
  resources :leagues, only: [:index, :show]
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
