class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @documents = Document.all
    respond_with(@documents)
  end

  def show
    respond_with(@document)
  end

  def new
    @document = Document.new
    respond_with(@document)
  end

  def edit
  end

  def create
    @document = Document.new(document_params)

    uploaded_io = params[:document][:file]

    @document.original_file_name = uploaded_io.original_filename
    @document.extension = File.extname(@document.original_file_name)
    @document.disc_file_name = Time.now.to_f.to_s.gsub!('.','') + @document.extension
    @document.path = File.join('public/uploads',@document.disc_file_name)
    
    #write the file
    File.open(Rails.root.join('public', 'uploads', @document.disc_file_name), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    unit = ' bytes'
    size = File.size(@document.path).to_f
    
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

    @document.size = size.round(2).to_s + unit

    @document.save

    redirect_to action: "index"
  end

  def download_file
    @document = Document.find(params[:id])
    send_file @document.path, :x_sendfile => true
  end


  def update
    @document.update(document_params)
    redirect_to action: "index"
  end

  def destroy
    @document.destroy
    FileUtils.remove_file(@document.path, force = true)
    respond_with(@document)
  end

  private
    def set_document
      @document = Document.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:name, :document_category_id, :path, :extension, :size)
    end
end
