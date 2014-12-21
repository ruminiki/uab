class RegistrationStatus < ActiveRecord::Base

	has_many :registrations, :dependent => :restrict_with_exception

	before_save :upper_case
	before_update :upper_case

	validates :name, presence: true

	def upper_case
		self.name = self.name.mb_chars.upcase.to_s
	end

	def self.search(session)
		name = session["search_registration_status_name"]
		where("registration_statuses.name like ?", "%#{name}%")
	end

end
