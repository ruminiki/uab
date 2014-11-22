class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :edit, :update, :destroy]
  respond_to :html, :xml, :json

  def index

    if params[:name]
      #session[:search_city_name] = params[:name]
      @cities = City.search(params[:name])
    else
      @cities = City.all
    end

    respond_with(@cities)

  end

  def show
    respond_with(@city)
  end

  def new
    @city = City.new
    respond_with(@city)
  end

  def edit
  end

  def create
    @city = City.new(city_params)
    if @city.valid?
      @city.save
      redirect_to action: "index", :notice => "City saved with success" 
    else
      respond_with(@city)  
    end
  end

  def update
    @city.update(city_params)
    redirect_to action: "index"
  end

  def destroy
    @city.destroy
    respond_with(@city)
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
