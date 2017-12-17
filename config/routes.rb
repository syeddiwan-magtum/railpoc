Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	
	
  post '/auth/login', to: 'authentication#authenticate'
  post '/signup', to: 'users#create'
  get '/users', to: 'users#index'
   
  
  resources :todos do
    resources :items
  end

  resources :projects do
  end
  
  resources :rfps do
  end

  get 'rfps_list', to: 'rfps#list'
  get 'rfps_pendinglist', to: 'rfps#pendinglist'
  


end
