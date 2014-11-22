class Document < ActiveRecord::Base

	belongs_to :document_category
	has_and_belongs_to_many :course_classes

	validates :name, presence: true
	validates :document_category, presence: true
	validates_associated :document_category
	validates :file, presence: true
	
	before_save :upper_case

	attr_accessor :file

	def upper_case
		self.name.upcase!
	end
	
	def save
		
	    self.original_file_name = self.file.original_filename
	    self.extension = File.extname(self.original_file_name)
	    self.disc_file_name = Time.now.to_f.to_s.gsub!('.','') + self.extension
	    self.path = File.join('public/uploads',self.disc_file_name)
	    
	    #write the file
	    File.open(Rails.root.join('public', 'uploads', self.disc_file_name), 'wb') do |file|
	      file.write(self.file.read)
	    end

	    unit = ' bytes'
	    size = File.size(self.path).to_f
	    
	    #converte para Kb caso tenha mais de um Kb
	    if (size / 1024) > 1
	      unit = ' Kb'
	      size = size / 1024  
	    end
	    
	    #converte para Mb caso tenha mais de um Mb
	    if (size / 1024 / 1024 ) > 1
	      unit = ' Mb'
	      size = size / 1024 / 1024
	    end

	    self.size = size.round(2).to_s + unit

	end


end
