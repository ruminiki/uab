Rails.application.routes.draw do
	


  	authenticate :user do
	  #invoke add student to classes
	  get  "course_classes/registrations" => "course_classes#registrations"	
	  get  "course_classes/add_student" => "course_classes#add_student"	
	  get  "course_classes/remove_student" => "course_classes#remove_student"  
	  get  "course_classes/redirect_to_edit_student_course_class" => "course_classes#redirect_to_edit_student_course_class"  
	  get  "course_classes/employees" => "course_classes#employees"	
	  get  "course_classes/add_employee" => "course_classes#add_employee"	
	  get  "course_classes/remove_employee" => "course_classes#remove_employee"  
	  get  "course_classes/documents" => "course_classes#documents"	
	  post "course_classes/add_document" => "course_classes#add_document"
	  get  "course_classes/remove_document" => "course_classes#remove_document"  
	  get  "course_classes/clear_search" => "course_classes#clear_search"  

	  get  "documents/download_file" => "documents#download_file"

	  get  "students/add_for_select" => "students#add_for_select"
	  get  "students/clear_search" => "students#clear_search"

	  get  "employees/add_for_select" => "employees#add_for_select"
	  get  "employees/clear_search" => "employees#clear_search"

      get  "cities/clear_search" => "cities#clear_search"

      get  "institutions/clear_search" => "institutions#clear_search"

      get  "courses/clear_search" => "courses#clear_search"

 	  get  "employee_categories/clear_search" => "employee_categories#clear_search"     

 	  get  "registration_statuses/clear_search" => "registration_statuses#clear_search"   

 	  get  "document_categories/clear_search" => "document_categories#clear_search"  

 	  get  "parameters/clear_search" => "parameters#clear_search"  

 	  post "accounts/update_user_account" => "accounts#update_user_account"  
 	  get  "accounts/activate_user" => "accounts#activate_user"  
 	  get  "accounts/inactivate_user" => "accounts#inactivate_user"  
 	  get  "accounts/authorizations" => "accounts#authorizations"	
 	  get  "accounts/update_authorization" => "accounts#update_authorization"

 	  get  "use_cases/clear_search" => "use_cases#clear_search"  

	  resources :accounts
	  resources :authorizations
	  resources :use_cases
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
	devise_scope :user do
	  authenticated :user do
	    root 'visitors#index', as: :authenticated_root
	  end

	  unauthenticated do
	    root 'devise/sessions#new', as: :unauthenticated_root
	  end
	end


	root :to => "visitors#index"
end
