Rails.application.routes.draw do
  #get 'posts/new'

  #get 'posts/index'
  #get 'posts/create'


  resources :posts, :only => [:new, :create, :index]

  root 'static_pages#home'
  
  get '/home', to: 'static_pages#home'

  get '/about', to: 'static_pages#about'

  get '/login', to: 'sessions#new'
 
  post '/login', to: 'sessions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  delete '/logout', to: 'sessions#destroy'
end
