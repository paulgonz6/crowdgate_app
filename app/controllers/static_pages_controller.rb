class StaticPagesController < ApplicationController

  def landing_page
    @event = Event.new
  end


end
