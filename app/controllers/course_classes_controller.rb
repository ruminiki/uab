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

  def destroy
    @course_class.destroy
    respond_with(@course_class)
  end

  #metodo para retornar para a página anterior
  def cancel
    redirect_to :back
  end

  #direciona para a pagina de matricula
  def registrations
    @course_class = CourseClass.find(params[:id])
    render '_form_add_students'
  end

  def redirect_to_edit_student_course_class
    @registration = Registration.where(course_class_id: params[:course_class_id], student_id: params[:student_id]).first
    redirect_to edit_registration_path(@registration)
  end

  def add_student
    @registration = Registration.new

    @course_class = CourseClass.find(params[:id])
    @student = Student.find(params[:student_id])

    id_status_inicial = Parameter.where(name: Parameter::ID_STATUS_INICIAL_MATRICULA).first
    if id_status_inicial.nil?
      redirect_to :back, :notice => "Parâmetro ID_STATUS_INICIAL_MATRICULA não definido. Contate o administrador"
    end
    
    @registration_status = RegistrationStatus.find(id_status_inicial.value.to_i)

    @registration.registration_status = @registration_status
    @registration.student = @student
    @registration.course_class = @course_class
    @course_class.registrations = Array.new if nil
    @course_class.registrations << @registration
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


  private
    def set_course_class
      @course_class = CourseClass.find(params[:id])
    end

    def course_class_params
      params.require(:course_class).permit(:name, :institution_id, :course_id, :begin)
    end
end
