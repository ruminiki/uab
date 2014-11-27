class RegistrationStatusesController < ApplicationController
  before_action :set_registration_status, only: [:show, :edit, :update, :destroy]
  respond_to :html
  
  include ModelSearchHelper

  def index
    @registration_statuses = self.search(params, RegistrationStatus)
    respond_with(@registration_statuses)
  end  
  
  def show
    respond_with(@registration_status)
  end

  def new
    @registration_status = RegistrationStatus.new
    respond_with(@registration_status)
  end

  def create
    @registration_status = RegistrationStatus.new(registration_status_params)
    @registration_status.save
    redirect_to action: "index"
  end

  def update
    @registration_status.update(registration_status_params)
    redirect_to action: "index"
  end

  def destroy
    @registration_status.destroy
    respond_with(@registration_status)
  end

  def clear_search
    session.delete :search_registration_status_name
    redirect_to action: "index"
  end

  private
    def set_registration_status
      @registration_status = RegistrationStatus.find(params[:id])
    end

    def registration_status_params
      params.require(:registration_status).permit(:name)
    end
end
