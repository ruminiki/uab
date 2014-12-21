class Employee < ActiveRecord::Base

	belongs_to :city, :autosave => true
	belongs_to :employee_category, :autosave => true
	
	has_and_belongs_to_many :course_classes, :dependent => :restrict_with_exception

	before_save :upper_case

	before_destroy :check_associations

	validates :name, :email, presence: true

	def upper_case
		self.name = self.name.mb_chars.upcase.to_s
		self.email = self.email.mb_chars.upcase.to_s
		self.address = self.address.mb_chars.upcase.to_s
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

	def check_associations
		!self.course_classes.any?
	end

end
