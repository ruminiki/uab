class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  respond_to :html, :xml, :json
  autocomplete :city, :name
  
  def index
    @employees = Employee.all
    respond_with(@employees)
  end

  def show
    respond_with(@employee)
  end

  def new
    @employee = Employee.new
    respond_with(@employee)
  end

  def edit
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

  private
    def set_employee
      @employee = Employee.find(params[:id])
    end

    def employee_params
      params.require(:employee).permit(:name, :phone_number, :rg, :cpf, :birthday, :employee_category_id, :city_id, :address, :email)
    end
end
