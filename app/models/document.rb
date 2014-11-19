class Document < ActiveRecord::Base

	belongs_to :document_category
	has_and_belongs_to_many :course_classes

	attr_accessor :file

end
