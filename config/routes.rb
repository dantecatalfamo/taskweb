Rails.application.routes.draw do
  # resources :heading_properties
  resources :users
  resources :notebooks
  resources :heading_states
  resources :headings do
    resources :heading_properties, shallow: true, path: 'properties'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/agenda', to: 'headings#agenda'
  get '/todos',  to: 'headings#todos'

  get '/', to: 'home#home', as: 'home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
