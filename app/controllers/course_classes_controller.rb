class CourseClassesController < ApplicationController
  
  before_action :set_course_class, only: [:show, :edit, :update, :destroy]
  respond_to :html

  autocomplete :student, :name, :full => true, :extra_data => [:id]
  autocomplete :employee, :name, :full => true, :extra_data => [:id]

  helper_method :add_student, :remove_student

  include ModelSearchHelper

  def index
    @course_classes = self.search(params, CourseClass)
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

  def clear_search
    session.delete :search_course_class_institution_name
    session.delete :search_course_class_course_name
    session.delete :search_course_class_name
    redirect_to action: "index"
  end

=begin
  MÉTODOS PARA ADICIONAR, REMOVER E EDITAR UMA MATRÍCULA DA TURMA
=end
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
    #limpa os erros que podem existir da requisição anterior
    @course_class.errors.clear
    
    begin
      @student = Student.find(params[:student_id])
    rescue
      @course_class.errors.add(:info, "Estudante não encontrado. Por favor selecione um estudante válido.")
    end
    
    id_status_inicial = Parameter.where(name: Parameter::ID_STATUS_INICIAL_MATRICULA).first
    if id_status_inicial.nil? || id_status_inicial.value.nil?
      @course_class.errors.add(:info, "Param ID_STATUS_INICIAL_MATRICULA is not defined. Please contact the system administrator.")
    else
      #rescue exception
      begin
        @registration_status = RegistrationStatus.find(id_status_inicial.value.to_i)
      rescue
        @course_class.errors.add(:info, "Registration Status not found with ID: " + id_status_inicial.value + ". Please insert the register.")
      end

    end

    #if occurred any erros, back to page
    if @course_class.errors.any?
      render '_form_add_students'
      return
    end

    @registration.registration_status = @registration_status
    @registration.student = @student
    #@registration.course_class = @course_class
    @course_class.registrations = Array.new if nil
    @course_class.registrations << @registration
    @course_class.save
    redirect_to :back, :notice => "Student added with success!"  
    
  end

  def remove_student
    @course_class = CourseClass.find(params[:id])
    @course_class.students.delete(params[:student_id])
    @course_class.save
    redirect_to :back, :notice => "Student removed with success!"
  end

=begin
  METODOS PARA ADICIONAR E REMOVER UM TUTOR DA TURMA
=end
  def employees
    @course_class = CourseClass.find(params[:id])
    render '_form_add_employees'
  end

  def add_employee

    @course_class = CourseClass.find(params[:id])
    #limpa os erros que podem existir da requisição anterior
    @course_class.errors.clear

    begin
      @employee = Employee.find(params[:employee_id])
    rescue
      @course_class.errors.add(:info, "Tutor não encontrado. Por favor selecione um tutor válido. ")
    end
    
    #if occurred any erros, back to page
    if @course_class.errors.any?
      render '_form_add_employees'
      return
    end

    @course_class.employees << @employee
    #@employee.course_classes << @course_class
    @course_class.save

    redirect_to :back, :notice => "Tutor adicionado com sucesso!"  
    
  end

  def remove_employee
    @course_class = CourseClass.find(params[:id])
    @course_class.employees.delete(params[:employee_id])
    @course_class.save
    redirect_to :back, :notice => "Tutor removido com sucesso!"
  end

=begin
  METODOS PARA ADICIONAR E REMOVER UM DOCUMENTO NA TURMA
=end
  def documents
    @course_class = CourseClass.find(params[:id])
    @course_class.document = Document.new
    render '_form_add_documents'
  end

  def add_document

    @course_class = CourseClass.find(params[:course_class_id])
    
    @course_class.document = Document.new(document_params)
    @course_class.document.file = params[:document][:file]
    @course_class.document.valid?

    #if occurred any erros, back to page
    if @course_class.document.errors.any?
      render '_form_add_documents'
      return
    end

    @course_class.document.save
    @course_class.documents << @course_class.document
    @course_class.save

    render '_form_add_documents', :notice => "Documento adicionado com sucesso!"  
    
  end

  def remove_document
    @course_class = CourseClass.find(params[:id])
    @course_class.document = Document.find(params[:document_id])

    @course_class.documents.delete(params[:document_id])
    @course_class.save
    @course_class.document.destroy

    FileUtils.remove_file(@course_class.document.path, force = true)
    render '_form_add_documents', :notice => "Documento removido com sucesso!"
  end  

  private
    def set_course_class
      @course_class = CourseClass.find(params[:id]) if params[:id].to_i > 0
    end

    def course_class_params
      params.require(:course_class).permit(:name, :institution_id, :course_id, :begin)
    end

    def document_params
      params.require(:document).permit(:name, :document_category_id, :path, :extension, :size)
    end
end
