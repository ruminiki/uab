class RegistrationStatus < ActiveRecord::Base

	before_save :upper_case
	before_update :upper_case

	def upper_case
		self.name.upcase!
	end

	def self.search(session)
		name = session["search_registration_status_name"]
		where("registration_statuses.name like ?", "%#{name}%")
	end

end
