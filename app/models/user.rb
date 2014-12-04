class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable

	has_many :authorizations

	def active_for_authentication?
	  super && self.active? # i.e. super && self.is_active
	end

	def inactive_message
	  "Desculpe, essa conta foi desativada. Por favor contate o administrador."
	end

	def auth_to_add(class_name)
		auth = self.authorizations.select { |a| a.use_case.class_name == class_name }
		return false if auth.nil? || auth.first.nil?
		return auth.first.add?
	end

	def auth_to_edit(class_name)
		auth = self.authorizations.select { |a| a.use_case.class_name == class_name }
		return false if auth.nil? || auth.first.nil?
		return auth.first.edit?
	end

	def auth_to_view(class_name)
		auth = self.authorizations.select { |a| a.use_case.class_name == class_name }
		return false if auth.nil? || auth.first.nil?
		return auth.first.view?
	end

	def auth_to_remove(class_name)
		auth = self.authorizations.select { |a| a.use_case.class_name == class_name }
		return false if auth.nil? || auth.first.nil?
		return auth.first.remove?
	end

end
