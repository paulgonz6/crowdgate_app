class BookingsController < ApplicationController

  def new
    @tailgate = Tailgate.find(params[:id])
  end

  def create
    @booking = Booking.new

    @booking.tailgate_id = params[:tailgate_id]
    @booking.user_id = 1

    @booking.save

    redirect_to booking_url(@booking.id)
  end

  def show
    @booking = Booking.find(params[:id])
    # @tailgate = Tailgate.find(params[:id])
    # @tailgate.size -= params[:quantity].to_i
    # @tailgate.save
  end

end
