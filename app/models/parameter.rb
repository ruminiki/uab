class Parameter < ActiveRecord::Base

	ID_STATUS_INICIAL_MATRICULA = "ID_STATUS_INICIAL_MATRICULA"
	#attr_reader :ID_STATUS_INICIAL_MATRICULA

	before_save :upper_case
	before_update :upper_case

	def upper_case
		self.name.upcase!
	end


end
