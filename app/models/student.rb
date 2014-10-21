class Student < ActiveRecord::Base
	belongs_to :city, :autosave => true
end
