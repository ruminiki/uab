class EmployeeCategory < ActiveRecord::Base
	validates :name, presence: true

	before_save :upper_case
	before_update :upper_case

	def upper_case
		self.name.upcase!
	end

	def self.search(session)
		name = session["search_employee_category_name"]
		where("employee_categories.name like ?", "%#{name}%")
	end

end
