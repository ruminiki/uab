class Employee < ActiveRecord::Base

	belongs_to :city, :autosave => true
	belongs_to :employee_category, :autosave => true
	before_save :upper_case

	def upper_case
		self.name.upcase!
		self.email.upcase!
		self.address.upcase!
	end

	def city_name
		city.name if city
	end

	def self.search(name, category)

		search = "";

		search += "Employee.joins(:employee_category)"
		search += ".where('employee_categories.name like ?', '%#{category}%')"
		search += ".where('employees.name like ?', '%#{name}%')"
		
		eval(search)

	end


end
