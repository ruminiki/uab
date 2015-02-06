class CitiesController < ApplicationController
  
  before_action :set_city, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js, :json

  include ModelSearchHelper

  def index
    @cities = self.search(params, City)
    @total = City.distinct.count('id')
  end

  def show
    respond_with(@city)
  end

  def new
    @city = City.new
    respond_with(@city)
  end

  def create
    @city = City.new(city_params)
    if @city.save
      redirect_to action: "index"
    else
      respond_with(@city)  
    end
  end

  def update
    if @city.update(city_params)
      redirect_to action: "index"
    else
      respond_with(@city)   
    end
  end

  def destroy
    @city.destroy
  end

  def clear_search
    session.delete :search_city_name
    redirect_to action: "index"
  end

  private
    def set_city
      @city = City.find(params[:id])
    end

    def city_params
      params.require(:city).permit(:name)
    end
end
