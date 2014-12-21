class Parameter < ActiveRecord::Base

	ID_STATUS_INICIAL_MATRICULA = "ID_STATUS_INICIAL_MATRICULA"

	before_save :upper_case
	before_update :upper_case

	validates :name, :value, :description, presence: true

	def upper_case
		self.name = self.name.mb_chars.upcase.to_s
	end

	def self.search(session)
		name = session["search_parameter_name"]
		where("parameters.name like ?", "%#{name}%")
	end

end
