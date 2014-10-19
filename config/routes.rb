Rails.application.routes.draw do
	
	authenticate :user do
	  resources :institutions
	  resources :students
	end

	devise_for :users
	root to: 'visitors#index'
end
