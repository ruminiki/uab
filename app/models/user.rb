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

end
