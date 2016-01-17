Rails.application.routes.draw do
  use_doorkeeper
  root 'pages#home'
  get '/home', to: 'pages#home'
  
  resources :recipes do
    member do
      post 'like'
    end
  end
  
  resources :chefs, except: [:new]
  
  get '/register', to: 'chefs#new' 
  
  get '/login', to: 'logins#new'
  post '/login', to: 'logins#create'
  get '/logout', to: 'logins#destroy'
  
  namespace :api do
    namespace :v1 do
      resources :recipes
    end
  end
  
end
