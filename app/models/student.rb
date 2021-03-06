class Student < ActiveRecord::Base

	belongs_to :city
	has_many :registrations, :dependent => :restrict_with_exception
	has_many :course_classes, :through => :registrations

	validates :name, :email, presence: true

	before_save :upper_case

	def upper_case
		self.name = self.name.mb_chars.upcase.to_s
		self.email = self.email.mb_chars.upcase.to_s
		self.badge_observation = self.badge_observation.mb_chars.upcase.to_s
		self.address = self.address.mb_chars.upcase.to_s
	end

	def city_name
		city.name if city
	end

	def city_name=(name)
		self.city = City.find_or_create_by_name(name) unless name.blank?
	end

	def self.search(session)

		name      = session["search_student_name"]
		city      = session["search_student_city_name"]
		has_badge = session["search_student_has_badge"]

		search = "";

		search += "Student.joins(:city).where('cities.name like ?', '%#{city}%')." unless city.nil? || city.blank?
		search += "where('students.name like ?', '%#{name}%')"
		
		if has_badge.present?
			if has_badge == 'yes'
				search += ".where('has_badge = ?', true)"
			elsif has_badge == 'no'
				search += ".where('has_badge = ?', false)"
			end
		end

		#remove o ponto final da última string
		#search.chop! if search.end_with? '.'

		eval(search)
		
	end

end
