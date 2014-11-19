class Document < ActiveRecord::Base

	belongs_to :document_category

	attr_accessor :file

end
