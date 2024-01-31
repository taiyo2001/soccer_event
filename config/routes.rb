Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'home#index'

  resources :events, only: %i[index new show create edit update destroy] do
    resources :event_attendances, only: %i[index new create update]
  end
end
