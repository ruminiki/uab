class CourseClass < ActiveRecord::Base

	belongs_to :institution, :class_name => 'Institution', :foreign_key => 'insitution_id'
	belongs_to :course, :class_name => 'Course', :foreign_key => 'course_id'

	before_save :upper_case
	before_update :upper_case

	def upper_case
		self.name.upcase!
	end

end
