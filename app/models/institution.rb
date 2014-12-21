class Institution < ActiveRecord::Base

	has_many :course_classes, :dependent => :restrict_with_exception

	validates :name, :acronym, presence: true

	before_save :upper_case
	before_update :upper_case

	def upper_case
		self.name = self.name.mb_chars.upcase.to_s
	end

	def self.search(session)
		name = session["search_institution_name"]
		where("institutions.name like ?", "%#{name}%")
	end

end
