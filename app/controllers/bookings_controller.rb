class BookingsController < ApplicationController
  before_action :set_booking, :only => [:show, :destroy]
  before_action :set_tailgate, :only => [:new, :show, :create]

  def new
    @booking = Booking.new(:tailgate => @tailgate)
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.tailgate = @tailgate
    @booking.set_buyer(current_user)
    @booking.set_amounts_and_fees(params)

    if @booking.save
      @booking.adjust_tailgate_size
      redirect_to tailgate_booking_url(@booking.tailgate_id, @booking.id)
    else
      redirect_to :back, :notice => "Someting went wrong"
    end
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

  private
    def set_booking
      @booking = Booking.find(params[:id])
    end

    def set_tailgate
      @tailgate = Tailgate.find(params[:tailgate_id])
    end

    def booking_params
      params.require(:booking).permit(:quantity, :email, :phone,
                                      :donation_amount, :checkout_as_guest)
    end
end
