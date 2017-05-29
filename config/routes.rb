Rails.application.routes.draw do
  root 'static_pages#home'
  
  get '/home', to: 'static_pages#home'

  get '/about', to: 'static_pages#about'

  get '/login', to: 'sessions#new'
 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
