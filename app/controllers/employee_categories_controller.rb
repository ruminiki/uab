class EmployeeCategoriesController < ApplicationController
  before_action :set_employee_category, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js, :json
  
  include ModelSearchHelper

  def index
    @employee_categories = self.search(params, EmployeeCategory)
    @total = EmployeeCategory.distinct.count('id')
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
    if @employee_category.save
      redirect_to action: "index"
    else
      respond_with(@employee_category)  
    end
  end

  def update
    if @employee_category.update(employee_category_params)
      redirect_to action: "index"
    else
      respond_with(@employee_category)  
    end
  end

  def destroy
    @employee_category.destroy
  end

  def clear_search
    session.delete :search_employee_category_name
    redirect_to action: "index"
  end

  private
    def set_employee_category
      @employee_category = EmployeeCategory.find(params[:id])
    end

    def employee_category_params
      params.require(:employee_category).permit(:name)
    end
end
