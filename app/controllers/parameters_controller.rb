class ParametersController < ApplicationController
  before_action :set_parameter, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js
  
  include ModelSearchHelper

  def index
    @parameters = self.search(params, Parameter)
    @total = Parameter.distinct.count('id')
    respond_with(@parameters)
  end

  def show
    respond_with(@parameter)
  end

  def new
    @parameter = Parameter.new
    respond_with(@parameter)
  end

  def edit
  end

  def create
    @parameter = Parameter.new(parameter_params)
    if @parameter.save
      redirect_to action: "index"  
    else
      respond_with(@parameter)  
    end
  end
  
  def update
    if @parameter.update(parameter_params)
      redirect_to action: "index"  
    else
      respond_with(@parameter)  
    end
  end

  def destroy
    @parameter.destroy
  end

  def clear_search
    session.delete :search_parameter_name
    redirect_to action: "index"
  end

  private
    def set_parameter
      @parameter = Parameter.find(params[:id])
    end

    def parameter_params
      params.require(:parameter).permit(:name, :value, :description)
    end
end
