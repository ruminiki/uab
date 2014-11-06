class CourseClassStudentsController < ApplicationController
  before_action :set_course_class_student, only: [:show, :edit, :update, :destroy]

  def index
    @course_class_students = CourseClassStudent.all
    respond_with(@course_class_students)
  end

  def show
    respond_with(@course_class_student)
  end

  def new
    @course_class_student = CourseClassStudent.new
    respond_with(@course_class_student)
  end

  def edit
  end

  def create
    @course_class_student = CourseClassStudent.new(course_class_student_params)
    @course_class_student.save
    respond_with(@course_class_student)
  end

  def update
    @course_class_student.update(course_class_student_params)
    respond_with(@course_class_student)
  end

  def destroy
    @course_class_student.destroy
    respond_with(@course_class_student)
  end

  private
    def set_course_class_student
      @course_class_student = CourseClassStudent.find(params[:id])
    end

    def course_class_student_params
      params.require(:course_class_student).permit(:student_id, :course_class_id, :note)
    end
end
