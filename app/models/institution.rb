class Institution < ActiveRecord::Base

	has_many :course_classes, :dependent => :restrict_with_exception

	validates :name, :acronym, presence: true

	def self.search(session)
		name = session["search_institution_name"]
		where("institutions.name like ?", "%#{name}%")
	end

end
