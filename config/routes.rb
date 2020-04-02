Rails.application.routes.draw do
  namespace :api do
  	namespace :v1 do
  		post 'authenticate', to: 'authentication#authenticate'
  		resources :users, only: [:show, :update, :create] do
  			collection do
  				post :change_password
  				post :reset_password
  			end
  		end
      resources :widgets, only: [:index, :create, :show]
    end
  end
end
