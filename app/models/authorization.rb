class Authorization < ActiveRecord::Base

	belongs_to :role
	belongs_to :use_case

end
