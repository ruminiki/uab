class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js
  
  include ModelSearchHelper

  def index
    @courses = self.search(params, Course)
    @total = Course.distinct.count('id')
    respond_with(@courses)
  end

  def show
    respond_with(@course)
  end

  def new
    @course = Course.new
    respond_with(@course)
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to action: "index"
    else
      respond_with(@course)  
    end
  end

  def update
    if @course.update(course_params)
      redirect_to action: "index"
    else
      respond_with(@course)  
    end
  end

  def destroy
    @course.destroy
  end

  def clear_search
    session.delete :search_course_name
    redirect_to action: "index"
  end

  private
    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:name, :acronym)
    end
end
