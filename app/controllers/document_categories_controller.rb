class DocumentCategoriesController < ApplicationController
 
  before_action :set_document_category, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js
  
  include ModelSearchHelper

  def index
    @document_categories = self.search(params, DocumentCategory)
    respond_with(@document_categories)
  end  
  
  def show
    respond_with(@document_category)
  end

  def new
    @document_category = DocumentCategory.new
    respond_with(@document_category)
  end

  def edit
  end

  def create
    @document_category = DocumentCategory.new(document_category_params)
    if @document_category.save
      redirect_to action: "index"
    else
      respond_with(@document_category)  
    end
  end

  def update
    if @document_category.update(document_category_params)
      redirect_to action: "index"
    else
      respond_with(@document_category)  
    end
  end

  def destroy
    @document_category.destroy
  end

  def clear_search
    session.delete :search_document_category_name
    redirect_to action: "index"
  end

  private
    def set_document_category
      @document_category = DocumentCategory.find(params[:id])
    end

    def document_category_params
      params.require(:document_category).permit(:name)
    end
end
