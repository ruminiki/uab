class CourseClass < ActiveRecord::Base

	belongs_to :institution, :class_name => 'Institution', :foreign_key => 'institution_id'
	belongs_to :course, :class_name => 'Course', :foreign_key => 'course_id'
	has_many :registrations
	has_many :students, :through => :registrations

	before_save :upper_case
	before_update :upper_case
	
	#selected student
	attr_accessor :student
	attr_accessor :student_id

	def upper_case
		self.name.upcase!
	end

end
