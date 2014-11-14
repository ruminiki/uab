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

	def self.search(name)
	  where("name like ?", "%#{name}%")
	end

end
