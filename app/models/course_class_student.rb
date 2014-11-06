class CourseClassStudent < ActiveRecord::Base

	belongs_to :student, :class_name => 'Student', :foreign_key => 'student_id'
	belongs_to :course_class, :class_name => 'CourseClass', :foreign_key => 'course_class_id'
	
end
