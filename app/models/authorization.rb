class Authorization < ActiveRecord::Base

	belongs_to :user
	belongs_to :use_case

end
