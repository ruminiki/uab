class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js, :json

  autocomplete :course_class, :name

  include ModelSearchHelper

  def index
    @registrations = self.search(params, Registration)
    @registration = Registration.new #para ser usado no form de pesquisa  no index

    #render :json => params

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
  end

  def clear_search
    session.delete :search_course_class_name_in_registration
    session.delete :search_student_name_in_registration
    redirect_to action: "index"
  end

  private
    def set_registration
      @registration = Registration.find(params[:id]) if !params[:id].to_i.zero?
    end

    def registration_params
      params.require(:registration).permit(:student_id, :course_class_id, :registration_status_id, :note, :date_abandonment, :date_conclusion, :end_note)
    end
end
