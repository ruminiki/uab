class UseCase < ActiveRecord::Base

  	has_many :authorizations

	before_save :upper_case
	before_update :upper_case

	def upper_case
		self.name.upcase!
	end

	def self.search(session)
		name = session["search_use_case_name"]
		where("use_cases.name like ?", "%#{name}%")
	end

end
