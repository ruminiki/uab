class Student < ActiveRecord::Base

	belongs_to :city, :autosave => true
	has_and_belongs_to_many :course_classes

end
