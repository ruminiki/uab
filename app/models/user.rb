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

	def auth_to_add(key)
		auth = self.authorizations.select { |a| a.use_case.key == key }
		return true if self.admin?
		return false if auth.nil? || auth.first.nil?
		return auth.first.add?
	end

	def auth_to_edit(key)
		auth = self.authorizations.select { |a| a.use_case.key == key }
		return true if self.admin?
		return false if auth.nil? || auth.first.nil?
		return auth.first.edit?
	end

	def auth_to_view(key)
		auth = self.authorizations.select { |a| a.use_case.key == key }
		return true if self.admin?
		return false if auth.nil? || auth.first.nil?
		return auth.first.view?
	end

	def auth_to_remove(key)
		auth = self.authorizations.select { |a| a.use_case.key == key }
		return true if self.admin?
		return false if auth.nil? || auth.first.nil?
		return auth.first.remove?
	end

end
