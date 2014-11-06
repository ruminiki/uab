class Student < ActiveRecord::Base

	belongs_to :city, :autosave => true
	has_and_belongs_to_many :course_classes

	before_save :upper_case

	def upper_case
		self.name.upcase!
		self.email.upcase!
		self.badge_observation.upcase!
		self.address.upcase!
	end

end
