class Institution < ActiveRecord::Base

	has_many :course_classes

	def self.search(session)
		name = session["search_institution_name"]
		where("institutions.name like ?", "%#{name}%")
	end

end
