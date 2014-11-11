class City < ActiveRecord::Base
	validates :name, :presence => true

	before_save :upper_case

	def upper
		self.name.upper
	end
end
