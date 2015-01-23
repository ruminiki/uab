class EventsController < ApplicationController
  
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  respond_to :html, :js, :json

  include ModelSearchHelper

  def index
    #session.delete :search_event_month_selected
    if session["search_event_month_selected"].blank?
      session["search_event_month_selected"] = Time.now.strftime("%Y-%m")
      @selected_month = Time.now.strftime("%B - %Y")
      @previous_month = (Time.now - 1.month).strftime("%B - %Y")
      @next_month = (Time.now + 1.month).strftime("%B - %Y")
    else
      @selected_month = Date.strptime(session["search_event_month_selected"],"%Y-%m")
      @previous_month = (@selected_month - 1.month).strftime("%B - %Y")
      @next_month = (@selected_month + 1.month).strftime("%B - %Y")
      @selected_month = @selected_month.strftime("%B - %Y")
    end
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
    @event.begin = @event.begin.strftime("%d/%m/%Y %H:%M")
    @event.end = @event.end.strftime("%d/%m/%Y %H:%M")
  end

  def create
    @event = Event.new(event_params)
    @event.begin = Time.parse(event_params[:begin] + 'UTC')
    @event.end = Time.parse(event_params[:end] + 'UTC')
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

  def previous_month
    @selected_month = Date.strptime(session["search_event_month_selected"],"%Y-%m") - 1.month
    @previous_month = (@selected_month - 1.month).strftime("%B - %Y")
    @next_month = (@selected_month + 1.month).strftime("%B - %Y")
    session["search_event_month_selected"] = @selected_month 
    @selected_month = @selected_month.strftime("%B - %Y")
    redirect_to action: "index"
  end

  def next_month
    @selected_month = Date.strptime(session["search_event_month_selected"],"%Y-%m") + 1.month
    @previous_month = (@selected_month - 1.month).strftime("%B - %Y")
    @next_month = (@selected_month + 1.month).strftime("%B - %Y")
    session["search_event_month_selected"] = @selected_month 
    @selected_month = @selected_month.strftime("%B - %Y")
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
