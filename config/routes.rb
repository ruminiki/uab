Rails.application.routes.draw do
	
  	authenticate :user do
	  #invoke add student to classes
	  get "course_classes/registrations" => "course_classes#registrations"	
	  get "course_classes/add_student" => "course_classes#add_student"	
	  get "course_classes/remove_student" => "course_classes#remove_student"  
	  get "course_classes/redirect_to_edit_student_course_class" => "course_classes#redirect_to_edit_student_course_class"  

	  resources :employee_categories
	  resources :document_categories
	  resources :parameters	  
	  resources :registration_statuses
	  resources :registrations
	  resources :institutions
	  resources :courses
	  
  	  resources :employees do
  	  	get :autocomplete_city_name, :on => :collection
  	  end

	  resources :students do
	  	get :autocomplete_city_name, :on => :collection
	  end

	  resources :course_classes do
	  	get :autocomplete_student_name, :on => :collection
	  end

	  resources :cities

	end

	devise_for :users
	root to: 'visitors#index'
end
