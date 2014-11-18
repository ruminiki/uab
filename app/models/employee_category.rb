class EmployeeCategory < ActiveRecord::Base
	validates :name, presence: true

	before_save :upper_case
	before_update :upper_case

	def upper_case
		self.name.upcase!
	end
end
