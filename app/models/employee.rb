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

end
