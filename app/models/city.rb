class City < ActiveRecord::Base
	validates :name, :presence => true

	def upper
		"#{self.name}.upper"
	end
end
