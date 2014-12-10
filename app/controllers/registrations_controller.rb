class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @registrations = Registration.joins(:course_class)
    respond_with(@registrations)
  end

  def show
    respond_with(@registration)
  end

  def new
    @registration = Registration.new
    respond_with(@registration)
  end

  def edit

  end

  def create
    @registration = Registration.new(registration_params)
    @registration.save
    redirect_to action: "index"
  end

  def update
    @registration.update(registration_params)
    redirect_to session["url_back_registration"]
  end

  def destroy
    @registration.destroy
    respond_with(@registration)
  end

  private
    def set_registration
      @registration = Registration.find(params[:id]) if !params[:id].to_i.zero?
    end

    def registration_params
      params.require(:registration).permit(:student_id, :course_class_id, :registration_status_id, :note, :date_abandonment, :date_conclusion, :end_note)
    end
end
