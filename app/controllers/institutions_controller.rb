class InstitutionsController < ApplicationController
  before_action :set_institution, only: [:show, :edit, :update, :destroy]
  respond_to :html, :xml, :json

  before_filter :authenticate_user!
  
  def index
    @institutions = Institution.all
    respond_with(@institutions)
  end

  def show
    respond_with(@institution)
  end

  def new
    @institution = Institution.new
    respond_with(@institution)
  end

  def edit
  end

  def create
    @institution = Institution.new(institution_params)
    @institution.save
    respond_with(@institution)
  end

  def update
    @institution.update(institution_params)
    redirect_to action: "index"
  end

  def destroy
    @institution.destroy
    respond_with(@institution)
  end

  private
    def set_institution
      @institution = Institution.find(params[:id])
    end

    def institution_params
      params.require(:institution).permit(:name, :phone_number, :email, :site)
    end
end
