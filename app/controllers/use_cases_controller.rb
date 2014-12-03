class UseCasesController < ApplicationController
  before_action :set_use_case, only: [:show, :edit, :update, :destroy]
  respond_to :html

  include ModelSearchHelper

  def index
    @use_cases = self.search(params, UseCase)
    respond_with(@use_cases)
  end

  def show
    respond_with(@use_case)
  end

  def new
    @use_case = UseCase.new
    respond_with(@use_case)
  end

  def edit
  end

  def create
    @use_case = UseCase.new(use_case_params)
    @use_case.save
    redirect_to action: "index"
  end

  def update
    @use_case.update(use_case_params)
    redirect_to action: "index"
  end

  def destroy
    @use_case.destroy
    respond_with(@use_case)
  end

  def clear_search
    session.delete :search_use_case_name
    redirect_to action: "index"
  end

  private
    def set_use_case
      @use_case = UseCase.find(params[:id])
    end

    def use_case_params
      params.require(:use_case).permit(:name, :class_name)
    end
end
