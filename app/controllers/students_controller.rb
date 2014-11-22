class StudentsController < ApplicationController

  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :close_window, only: [:index]
  respond_to :html
  
  autocomplete :student, :name

  def index
    namespace :students_controller do
      
    end@students = Student.search(params[:name], params[:student], params[:has_badge])
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
    if @student.valid?
      @student.save
      redirect_to action: "index", :notice => "Student saved with success" 
    else
      respond_with(@student)
    end
  end

  def update
    @student.update(student_params)
    redirect_to action: "index"
  end

  def destroy
    @student.destroy
    respond_with(@student)
  end

  #action invocada a partir de uma tela que tem associação com estudante
  #após salvar, a tela deve ser fechada
  def add_for_select
    session[:is_adding_for_select] = true
    redirect_to action: "new"
  end

  private
    def set_student
      @student = Student.find(params[:id]) if params[:id].to_i > 0
    end

    def student_params
      params.require(:student).permit(:name, :phone_number, :email, :has_badge, 
                :badge_observation, :birthday, :address, :student_id,
                :rg, :cpf, :sanguine_type)
    end

    def close_window
      render 'window.close' if session[:is_adding_for_select]
      session[:is_adding_for_select] = false
    end

end
