class Registration < ActiveRecord::Base

	belongs_to :student, :class_name => 'Student', :foreign_key => 'student_id'
	belongs_to :course_class, :class_name => 'CourseClass', :foreign_key => 'course_class_id'
	belongs_to :registration_status, :class_name => 'RegistrationStatus', :foreign_key => 'registration_status_id'

	def course_class_name
		course_class.name if course_class
	end

	def student_name
		student.name if student
	end


end
