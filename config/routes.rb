Rails.application.routes.draw do
	
	authenticate :user do
	  resources :institutions
	  resources :courses
	  resources :students do
	  	get :autocomplete_city_name, :on => :collection
	  end
	  resources :course_classes
	  resources :cities
	end

	devise_for :users
	root to: 'visitors#index'
end
