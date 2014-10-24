class Course < ActiveRecord::Base

	has_many :course_classes

	validates :name, :uniqueness => { :case_sensitive => false }
	validates :acronym, :uniqueness => { :case_sensitive => false }

	before_save :upper_case

	def upper_case
		self.name.upcase!
		self.acronym.upcase!
	end

end
