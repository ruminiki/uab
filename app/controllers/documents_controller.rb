class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js

  def index
    @documents = Document.all
    @total = Document.distinct.count('id')
    respond_with(@documents)
  end

  def show
    respond_with(@document)
  end

  def new
    @document = Document.new
    respond_with(@document)
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
  end

  private
    def set_document
      @document = Document.find(params[:id])
    end

    def document_params
      params.require(:document).permit(:name, :document_category_id, :path, :extension, :size)
    end
end
