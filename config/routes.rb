Rails.application.routes.draw do
  resources :teams, only: [:show] do
    resources :team_comments, only: %i[index]
  end
  resources :leagues, only: %i[index show]
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  resources :users, only: %i[index show]
  resources :team_comments, only: %i[create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'events#index'

  resources :events, only: %i[new show create edit update destroy] do
    resources :event_attendances, only: %i[index new create update]
    resources :event_comments, only: %i[index new create update]
    resources :favorites, only: %i[create destroy]
    collection do
      get 'applied'
    end
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
