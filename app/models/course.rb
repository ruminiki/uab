class Course < ActiveRecord::Base

	has_many :course_classes, :dependent => :restrict_with_exception

	validates :name, :uniqueness => { :case_sensitive => false }, :presence => true
	validates :acronym, :uniqueness => { :case_sensitive => false }, :presence => true

	before_save :upper_case

	def upper_case
		self.name = self.name.mb_chars.upcase.to_s
		self.acronym = self.acronym.mb_chars.upcase.to_s
	end

	def self.search(session)
		name = session["search_course_name"]
		where("courses.name like ?", "%#{name}%")
	end

end
