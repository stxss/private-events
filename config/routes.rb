Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "events#index"

  devise_for :users

  resources :events do
    resources :invitations
  end
  resources :users, except: [:show]
  resources :event_attendances

  get "profile", to: "users#show"
end
