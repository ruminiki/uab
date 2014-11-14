class City < ActiveRecord::Base
	validates :name, presence: true#, :message => "Name can't be empty"

	before_save :upper_case
	before_update :upper_case

	def upper_case
		self.name.upcase!
	end
end
