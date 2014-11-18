class EmployeeCategoriesController < ApplicationController
  before_action :set_employee_category, only: [:show, :edit, :update, :destroy]
  respond_to :html, :xml, :json
  
  def index
    @employee_categories = EmployeeCategory.all
    respond_with(@employee_categories)
  end

  def show
    respond_with(@employee_category)
  end

  def new
    @employee_category = EmployeeCategory.new
    respond_with(@employee_category)
  end

  def edit
  end

  def create
    @employee_category = EmployeeCategory.new(employee_category_params)
    @employee_category.save
    redirect_to action: "index"
  end

  def update
    @employee_category.update(employee_category_params)
    redirect_to action: "index"
  end

  def destroy
    @employee_category.destroy
    respond_with(@employee_category)
  end

  private
    def set_employee_category
      @employee_category = EmployeeCategory.find(params[:id])
    end

    def employee_category_params
      params.require(:employee_category).permit(:name)
    end
end
