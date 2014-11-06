class CourseClass < ActiveRecord::Base

	belongs_to :institution, :class_name => 'Institution', :foreign_key => 'institution_id'
	belongs_to :course, :class_name => 'Course', :foreign_key => 'course_id'
	has_many :course_class_students
	has_many :students, :through => :course_class_students

	before_save :upper_case
	before_update :upper_case

	def upper_case
		self.name.upcase!
	end

	def student
		@student
	end

end
