class Registration < ActiveRecord::Base

	belongs_to :student, :class_name => 'Student', :foreign_key => 'student_id'
	belongs_to :course_class, :class_name => 'CourseClass', :foreign_key => 'course_class_id'
	belongs_to :registration_status, :class_name => 'RegistrationStatus', :foreign_key => 'registration_status_id'

	validates_presence_of :registration_status

	def course_class_name
		course_class.name if course_class
	end

	def student_name
		student.name if student
	end

	def self.search(session)

		course_class = session["search_course_class_name_in_registration"]
		student      = session["search_student_name_in_registration"]
		status       = session["search_registration_in_status"]

		search = "";

		search += "Registration.joins(:course_class, :student)"
		search += ".where('course_classes.name like ? and students.name like ? ', '%#{course_class}%', '%#{student}%')"
		
		if status.present?
			search += ".where('registration_status_id = ?', #{status})"
		end

		eval(search)

	end

end
