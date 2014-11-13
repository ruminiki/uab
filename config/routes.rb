Rails.application.routes.draw do
	
  resources :course_class_students

	authenticate :user do
	  #invoke add student to classes
	  get "course_classes/redirect_to_add_student" => "course_classes#redirect_to_add_student"	
	  get "course_classes/add_student" => "course_classes#add_student"	
	  get "course_classes/remove_student" => "course_classes#remove_student"  
	  get "course_class_students/redirect_to_edit_student_course_class" => "course_class_students#redirect_to_edit_student_course_class"  
	  
	  resources :course_class_students
	  resources :institutions
	  resources :courses

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
