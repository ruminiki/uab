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

	def initialize
    	@errors = ActiveModel::Errors.new(self)
  	end

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
