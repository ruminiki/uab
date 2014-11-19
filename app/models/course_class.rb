class CourseClass < ActiveRecord::Base

	belongs_to :institution, :class_name => 'Institution', :foreign_key => 'institution_id'
	belongs_to :course, :class_name => 'Course', :foreign_key => 'course_id'
	has_many :registrations
	has_many :students, :through => :registrations
	has_and_belongs_to_many :employees

	before_save :upper_case
	before_update :upper_case
	
	#selected student
	attr_accessor :student
	attr_accessor :student_id

	#selected employee
	attr_accessor :employee
	attr_accessor :employee_id

	def upper_case
		self.name.upcase!
	end

	def self.search(name, institution, course)

		search = "";

		search += "CourseClass.joins(:institution, :course)"
		search += ".where('institutions.name like ? and courses.name like ? ', '%#{institution}%', '%#{course}%')"
		search += ".where('course_classes.name like ?', '%#{name}%')"
		
		eval(search)

	end

end
