require 'json'
require 'open-uri'

class EventsController < ApplicationController

  def delete
    @event = Event.find_by({ :id => params[:id]})
  end

  def destroy
    event = Event.find_by({ :id => params[:id]})
    event.destroy
    redirect_to('/events/index')
  end

  def edit
    @event = Event.find_by({ :id => params[:id]})
  end

  def save
    event = Event.find_by({ :id => params[:id]})

    puts

    event.name = params[:name]
    event.date = params[:date]
    event.time = params[:time]
    event.venue = params[:venue]
    event.city = params[:city]
    event.state = params[:state]
    event.save

    redirect_to('/events/index')
  end

  def index
    @events = Event.all
  end

  def new
  end

  def add
    search = "#{params[:name]} Football"
    safe_search = URI.encode(search)
    url = "http://api.eventful.com/json/events/search?app_key=mW23BC9SZCPfrVgP&keywords=#{safe_search}&date=Future"

    parsed_data = JSON.parse(open(url).read)
    @events = parsed_data["events"]["event"]

    @events.each do |event|
      new_event = Event.new
      new_event.name = event["title"]
      new_event.date = event["start_time"]
      new_event.time = event["start_time"]
      new_event.venue = event["venue_name"]
      new_event.city = event["city_name"]
      new_event.state = event["region_abbr"]
      new_event.ap_id = event["id"]
      new_event.api_modified = event["modified"]
      new_event.save
    end

    redirect_to('/events/index')
  end

end
