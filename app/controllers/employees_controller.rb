class EmployeesController < ApplicationController

  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  before_action :close_window, only: [:index]
  respond_to :html, :xml, :json
  autocomplete :city, :name
  
  include ModelSearchHelper

  def index
    @employees = self.search(params, Employee)
    respond_with(@employees)
  end

  def show
    respond_with(@employee)
  end

  def new
    @employee = Employee.new
    respond_with(@employee)
  end

  def create
    @employee = Employee.new(employee_params)
    @employee.save
    redirect_to action: "index"
  end

  def update
    @employee.update(employee_params)
    redirect_to action: "index"
  end

  def destroy
    @employee.destroy
    respond_with(@employee)
  end

  def clear_search
    session.delete :search_employee_name
    session.delete :search_employee_category_name
    redirect_to action: "index"
  end

  #action invocada a partir de uma tela que tem associação com colaborador
  #após salvar, a tela deve ser fechada
  def add_for_select
    session[:is_adding_for_select] = true
    redirect_to action: "new"
  end

  private
    def set_employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:name, :phone_number, :rg, :cpf, :birthday, :employee_category_id, :city_id, :address, :email)
    end

    def close_window
      render 'window.close' if session[:is_adding_for_select]
      session[:is_adding_for_select] = false
    end

end
