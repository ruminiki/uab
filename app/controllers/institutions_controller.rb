class InstitutionsController < ApplicationController
  before_action :set_institution, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js, :json

  before_filter :authenticate_user!
  
  include ModelSearchHelper

  def index
    @institutions = self.search(params, Institution)
    @total = Institution.distinct.count('id')
    respond_with(@institutions)
  end

  def show
    respond_with(@institution)
  end

  def new
    @institution = Institution.new
    respond_with(@institution)
  end

  def create
    @institution = Institution.new(institution_params)
    if @institution.save
      redirect_to action: "index"  
    else
      respond_with(@institution)  
    end
  end

  def update
    if @institution.update(institution_params)
      redirect_to action: "index"  
    else
      respond_with(@institution)  
    end
  end

  def destroy
    @institution.destroy
  end

  def clear_search
    session.delete :search_institution_name
    redirect_to action: "index"
  end

  private
    def set_institution
      @institution = Institution.find(params[:id])
    end

    def institution_params
      params.require(:institution).permit(:name, :phone_number, :email, :site, :contact, :acronym)
    end
end
