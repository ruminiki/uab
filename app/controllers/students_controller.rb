class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  respond_to :html
  autocomplete :city, :name, :full => true

  def index
    @students = Student.all
    respond_with(@students)
  end

  def show
    respond_with(@student)
  end

  def new
    @student = Student.new
    @student.city = City.new
    respond_with(@student)
  end

  def create
    @student = Student.new(student_params)
    @student.city = City.find(@student.city)
    @student.save
    redirect_to action: "index"
  end

  def update
    @student = Student.new(student_params)
    @student.city = City.find(@student.city)
    @student.update
    redirect_to action: "index"
  end

  def destroy
    @student.destroy
    respond_with(@student)
  end

  private
    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:name, :phone_number, :email, :has_badge, :badge_observation, :birthday, :address, :city_id)
    end
end
