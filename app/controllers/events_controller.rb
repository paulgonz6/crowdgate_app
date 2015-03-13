require 'json'
require 'open-uri'
require 'time'

class EventsController < ApplicationController

  before_action :authenticate_user!
  before_action :is_user_admin?

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      flash[:success] = "Event created succesfully"
      redirect_to :back
    else
      render('events/new')
    end

  end

  def index
    @events = Event.all
  end

  def edit
    @event = Event.find_by({ :id => params[:id]})
  end

  def update
    @event = Event.find_by({ :id => params[:id]})

    @event.name = params[:name]
    @event.date = params[:date]
    @event.time = params[:time]
    @event.venue = params[:venue]
    @event.city = params[:city]
    @event.state = params[:state]

    if @event.save
      redirect_to(events_url)
    else
      render('events/edit')
    end
  end


  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to(events_url)
  end

  def bulk_create
    search = "#{params[:name]} Football"
    safe_search = URI.encode(search)
    url = "http://api.eventful.com/json/events/search?app_key=mW23BC9SZCPfrVgP&keywords=#{safe_search}&date=Future"

    parsed_data = JSON.parse(open(url).read)
    @events = parsed_data["events"]["event"]

    @events.each do |event|
      new_event = Event.new
      new_event.name = event["title"]
      new_event.venue = event["venue_name"]
      new_event.city = event["city_name"]
      new_event.state = event["region_abbr"]
      new_event.ap_id = event["id"]
      new_event.api_modified = event["modified"]

      time = Time.parse(event["start_time"])
      date = Time.parse(event["start_time"])

      new_event.time = time.strftime("%I:%M%p, %Z")
      new_event.date = date.strftime("%B %d, %Y")
      new_event.save
    end

    redirect_to(events_url)
  end

  private
    def event_params
      params.require(:event).permit(:name, :date, :time, :venue, :city, :state)
    end

end
