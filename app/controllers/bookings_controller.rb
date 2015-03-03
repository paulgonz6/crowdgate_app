class BookingsController < ApplicationController
  before_action :set_booking, :only => [:show, :destroy]

  def new
    @tailgate = Tailgate.find(params[:tailgate_id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.new
    @booking.tailgate_id = params[:tailgate_id]
    @booking.quantity = params[:quantity]
    @booking.user_id = current_user.id

    tickets_total = @booking.quantity * Tailgate.find(@booking.tailgate_id).price

    taxes = tickets_total * 0.10
    fees = ((tickets_total + taxes)*0.029) + 0.30
    @booking.amount = (tickets_total + taxes + fees)

    @booking.process_payment(params[:stripeToken], @booking.amount)

    tailgate = Tailgate.find(@booking.tailgate_id)
    tailgate.current_size -= @booking.quantity
    tailgate.save

    @booking.save

    redirect_to booking_url(@booking.id)

  end

  def show
  end

  def index
    @bookings = Booking.all
  end

  def destroy
    charge = @booking.stripe_token

    @booking.refund(charge)

    tailgate = @booking.tailgate
    tailgate.current_size += @booking.quantity
    tailgate.save

    @booking.destroy

    flash[:danger] = "You've cancelled your tailgate. We're sorry that you can't make it. You will be refunded in 10 business days."
    redirect_to user_url(@booking.user_id)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

end
