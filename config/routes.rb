Rails.application.routes.draw do
	
  	authenticate :user do
	  #invoke add student to classes
	  get "course_classes/registrations" => "course_classes#registrations"	
	  get "course_classes/add_student" => "course_classes#add_student"	
	  get "course_classes/remove_student" => "course_classes#remove_student"  
	  get "course_classes/redirect_to_edit_student_course_class" => "course_classes#redirect_to_edit_student_course_class"  

	  get "course_classes/employees" => "course_classes#employees"	
	  get "course_classes/add_employee" => "course_classes#add_employee"	
	  get "course_classes/remove_employee" => "course_classes#remove_employee"  

	  get "course_classes/documents" => "course_classes#documents"	
	  post "course_classes/add_document" => "course_classes#add_document"	
	  get "course_classes/remove_document" => "course_classes#remove_document"  

	  get "documents/download_file" => "documents#download_file"

	  get "students/add_for_select" => "students#add_for_select"

	  get "employees/add_for_select" => "employees#add_for_select"

	  resources :documents
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
	  	get :autocomplete_employee_name, :on => :collection
	  end

	  resources :cities

	end

	devise_for :users
	root to: 'visitors#index'
end
