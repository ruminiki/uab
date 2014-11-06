class CourseClassesController < ApplicationController
  
  before_action :set_course_class, only: [:show, :edit, :update, :destroy]
  respond_to :html
  autocomplete :student, :name, :full => true, :extra_data => [:id]


  helper_method :add_student, :remove_student


  def index
    @course_classes = CourseClass.joins(:institution, :course)
    respond_with(@course_classes)
  end

  def show
    respond_with(@course_class)
  end

  def new
    @course_class = CourseClass.new
    respond_with(@course_class)
  end

  def edit
  end

  def create
    @course_class = CourseClass.new(course_class_params)
    @course_class.save
    redirect_to action: "index"
  end

  def update
    @course_class.update(course_class_params)
    redirect_to action: "index"
  end

  def redirect_to_add_student
    @course_class = CourseClass.find(params[:id])
    render '_form_add_students'
  end

  def add_student
    @course_class = CourseClass.find(params[:id])
    @course_class.students << Student.find(params[:student_id])
    @course_class.save
    #redirect_to :back, :notice => "Student added with success!"
    redirect_to :back
  end

  def remove_student
    @course_class = CourseClass.find(params[:id])
    @course_class.students.delete(params[:student_id])
    @course_class.save
    redirect_to :back
  end

  def destroy
    @course_class.destroy
    respond_with(@course_class)
  end

  private
    def set_course_class
      @course_class = CourseClass.find(params[:id])
    end

    def course_class_params
      params.require(:course_class).permit(:name, :institution_id, :course_id, :begin)
    end
end
