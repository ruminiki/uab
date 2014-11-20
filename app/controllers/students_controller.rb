class StudentsController < ApplicationController

  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :close_window, only: [:index]
  respond_to :html
  
  autocomplete :city, :name

  def index
    @students = Student.search(params[:name], params[:city], params[:has_badge])
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

    redirect_to action: "index"  

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
    session[:is_adding_for_select] = 'YES'
    redirect_to action: "new"
  end

  private
    def set_student
      @student = Student.find(params[:id]) if params[:id].to_i > 0
    end

    def student_params
      params.require(:student).permit(:name, :phone_number, :email, :has_badge, 
                :badge_observation, :birthday, :address, :city_id,
                :rg, :cpf, :sanguine_type, :is_adding_for_select)
    end

    def close_window
      if session[:is_adding_for_select] == 'YES'
        session[:is_adding_for_select] = 'NO'
        #fechar a janela atual
        render 'window.close' #page with javascript to close
      end
    end

end
