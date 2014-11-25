class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  respond_to :html
  
  include ModelSearchHelper

  def index
    @courses = self.search(params, Course)
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
    @course.save
    redirect_to action: "index"
  end

  def update
    @course.update(course_params)
    redirect_to action: "index"
  end

  def destroy
    @course.destroy
    respond_with(@course)
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
