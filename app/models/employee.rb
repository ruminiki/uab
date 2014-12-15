class Employee < ActiveRecord::Base

	belongs_to :city, :autosave => true
	belongs_to :employee_category, :autosave => true
	has_and_belongs_to_many :course_classes

	before_save :upper_case

	validates :name, :email, presence: true

	def upper_case
		self.name.upcase!
		self.email.upcase!
		self.address.upcase!
	end

	def city_name
		city.name if city
	end

	def self.search(session)

		name     = session["search_employee_name"]
		category = session["search_employee_category_name"]

		search = "";

		search += "Employee.joins(:employee_category)"
		search += ".where('employee_categories.name like ?', '%#{category}%')"
		search += ".where('employees.name like ?', '%#{name}%')"
		
		eval(search)

	end


end
