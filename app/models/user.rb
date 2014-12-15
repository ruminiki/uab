class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable

	has_and_belongs_to_many :roles

	#selected role
	attr_accessor :role
	attr_accessor :role_id

	def active_for_authentication?
	  super && self.active? # i.e. super && self.is_active
	end

	def inactive_message
	  "Desculpe, essa conta foi desativada. Por favor contate o administrador."
	end

	def auth_to_add(key)
		return true if self.admin?
		self.roles.each do |role|
			auth = role.authorizations.select { |a| !a.use_case.nil? && a.use_case.key == key }
			return true if auth && auth.first && auth.first.add?
		end
		return false
	end

	def auth_to_edit(key)
		return true if self.admin?
		self.roles.each do |role|
			auth = role.authorizations.select { |a| !a.use_case.nil? && a.use_case.key == key }
			return true if auth && auth.first && auth.first.edit?
		end
		return false	
	end

	def auth_to_view(key)
		return true if self.admin?
		self.roles.each do |role|
			auth = role.authorizations.select { |a| !a.use_case.nil? && a.use_case.key == key }
			return true if auth && auth.first && auth.first.view?
		end
		return false
	end

	def auth_to_remove(key)
		return true if self.admin?
		self.roles.each do |role|
			auth = role.authorizations.select { |a| !a.use_case.nil? && a.use_case.key == key }
			return true if auth && auth.first && auth.first.remove?
		end
		return false
	end

	def self.search(session)

		name   = session["search_user_name"]
		status = session["search_user_status"]

		search = "where('users.name like ? ', '%#{name}%')"

		search += ".where('active = ?', true)" if status == 'active'
		search += ".where('active = ?', false)" if status == 'inactive'
		
		#não permite que o administrador veja o super user
		search += ".where('super = ?', false)"
		
		eval(search)

	end	

end
