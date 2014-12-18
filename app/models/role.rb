class Role < ActiveRecord::Base

	has_and_belongs_to_many :users
	has_many :authorizations, :dependent => :delete_all

	validates :name, presence: true

	before_save :upper_case
	before_update :upper_case

	def upper_case
		self.name.upcase!
	end

	def self.search(session)
		name = session["search_role_name"]
		where("roles.name like ?", "%#{name}%")
	end

end
