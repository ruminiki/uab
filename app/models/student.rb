class Student < ActiveRecord::Base

	belongs_to :city, :autosave => true
	has_many :registrations
	has_many :course_classes, :through => :registrations

	before_save :upper_case

	def upper_case
		self.name.upcase!
		self.email.upcase!
		self.badge_observation.upcase!
		self.address.upcase!
	end

	def city_name
		city.name if city
	end

	def city_name=(name)
		self.city = City.find_or_create_by_name(name) unless name.blank?
	end

	def self.search(name, city, has_badge)

		search = "";

		if city.present?
			search += "Student.joins(:city).where('cities.name like ?', '%#{city}%')."
		end

		if name.present?
			search += "where('students.name like ?', '%#{name}%')." #$ usado para o replace
		end

		if has_badge.present?
			if has_badge == 'yes'
				search += "where('has_badge = ?', true)"
			elsif has_badge == 'no'
				search += "where('has_badge = ?', false)"
			end
		end

		#remove o ponto final da última string
		search.chop! if search.end_with? '.'

		if search.empty?
			all
		else
			eval(search)
		end

	end

end
