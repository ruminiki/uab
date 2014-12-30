class EventsController < ApplicationController
  
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js, :json

  include ModelSearchHelper

  def index
    session["search_event_begin"] = Time.now.strftime("%d/%m/%Y 00:00") if session["search_event_begin"].blank?
    @events = self.search(params, Event)
  end

  def show
    respond_with(@event)
  end

  def new
    @event = Event.new
    respond_with(@event)
  end

  def edit
    @event.begin = @event.begin.strftime("%d/%m/%Y %H:%m")
    @event.end = @event.end.strftime("%d/%m/%Y %H:%m")
  end

  def create
    @event = Event.new(event_params)
    @event.begin = Time.parse(event_params[:begin])
    @event.end = Time.parse(event_params[:end])
    if @event.save
      redirect_to action: "index"
    else
      respond_with(@event)  
    end
  end

  def update
    @event.begin = Time.parse(event_params[:begin])
    @event.end = Time.parse(event_params[:end])
    if @event.update(event_params)
      redirect_to action: "index"
    else
      respond_with(@event)   
    end
  end

  def destroy
    @event.destroy
  end

  def clear_search
    session.delete :search_event_name
    session.delete :search_event_begin
    session.delete :search_event_end
    redirect_to action: "index"
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :begin, :end, :local, :resume)
    end
end
