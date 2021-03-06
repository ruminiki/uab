class StudentsController < ApplicationController

  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :close_window, only: [:index]
  respond_to :html, :js
  autocomplete :city, :name

  include ModelSearchHelper
  include ModelAddForSelectHelper

  def index
    @students = self.search(params, Student)
    respond_with(@students)
  end

  def show
    respond_with(@student)
  end

  def new
    @student = Student.new
    respond_with(@student)
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to action: "index"
    else
      respond_with(@student)
    end
  end

  def update
    if @student.update(student_params)
      redirect_to action: "index"
    else
      respond_with(@student)
    end
  end

  def destroy
    @student.destroy
  end

  def clear_search
    session.delete :search_student_has_badge
    session.delete :search_student_city_name
    session.delete :search_student_name
    redirect_to action: "index"
  end

  private
    def set_student
      @student = Student.find(params[:id]) if params[:id].to_i > 0
    end

    def student_params
      params.require(:student).permit(:name, :phone_number, :email, :has_badge, 
                :badge_observation, :birthday, :address, :student_id,
                :rg, :cpf, :sanguine_type, :badge_end_date, :badge_number, :mobile_phone_number)
    end

end
