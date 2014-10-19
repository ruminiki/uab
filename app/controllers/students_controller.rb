class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  respond_to :html
  
  def index
    @students = Student.all
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
    @student.save
    respond_with(@student)
  end

  def update
    @student.update(student_params)
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
      params.require(:student).permit(:name, :phone_number, :email, :has_badge, :badge_observation, :birthday, :address)
    end
end
