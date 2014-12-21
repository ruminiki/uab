class City < ActiveRecord::Base
	validates :name, presence: true

	has_many :students, :dependent => :restrict_with_exception
	has_many :employees, :dependent => :restrict_with_exception

	before_save :upper_case
	before_update :upper_case

	def upper_case
		self.name = self.name.mb_chars.upcase.to_s
	end

	def self.search(session)
		name = session["search_city_name"]
		where("cities.name like ?", "%#{name}%")
	end

end
