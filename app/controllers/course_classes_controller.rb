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

  def redirect_to_edit_student_course_class
    @course_class_student = CourseClassStudent.find(:first,
      :conditions => ['course_class_id = ? AND student_id = ?', params[:couse_class_id], params[:student_id]])
    render '../course_class_students/_form'
  end

  def add_student
    @course_class = CourseClass.find(params[:id])
    @student = Student.find(params[:student_id])
    @course_class_student = CourseClassStudent.new
    @course_class_student.student = @student
    @course_class_student.course_class = @course_class
    @course_class.course_class_students = Array.new if nil
    @course_class.course_class_students << @course_class_student
    @course_class.save
    redirect_to :back, :notice => "Student added with success!"
    #redirect_to :back
  end

  def remove_student
    @course_class = CourseClass.find(params[:id])
    @course_class.students.delete(params[:student_id])
    @course_class.save
    redirect_to :back, :notice => "Student removed with success!"
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
