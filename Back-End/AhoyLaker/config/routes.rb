Rails.application.routes.draw do

    resource :user_session
    resource :account, :controller => 'users'
    resources :users
	namespace :api do
		resources :organizations do
			resources :dinings do
				resources :hours
				resources :menus
			end
			resources :offers
		end
	end
  
    resources :organizations do 
        resources :dinings do 
            resources :hours
            resources :menus
        end
        resources :offers
    end

  root 'sessions#new'

  get 'signup'  => 'users#new' 
  resources :users
  
  get '/login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
