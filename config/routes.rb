Rails.application.routes.draw do
  resources :users
  resources :notebooks
  resources :heading_states
  resources :headings
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/agenda", to: "headings#agenda"

  get "/", to: "home#home", as: "home"
end
