class BookingsController < ApplicationController

  def new
    @tailgate = Tailgate.find(params[:id])
  end

  def create
    @booking = Booking.new

    @booking.tailgate_id = params[:tailgate_id]
    @booking.quantity = params[:quantity]
    @booking.user_id = 1
    @booking.amount = @booking.quantity * Tailgate.find(@booking.tailgate_id).price

    @booking.process_payment(params[:stripeToken], @booking.amount)


    respond_to do |format|
      if @booking.save
        # Tell the UserMailer to send a welcome email after save
        BookingMailer.receipt_email(@booking).deliver_now
        format.html { redirect_to @booking }
        format.json { render json: @booking, status: :created, location: @booking }
      else
        format.html { render action: 'bookings/new' }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end

  end

  def show
    @booking = Booking.find(params[:id])
  end

  def index
    @bookings = Booking.all
  end

  def destroy
    @booking = Booking.find(params[:id])
    charge = @booking.stripe_token

    @booking.refund(charge)

    tailgate = @booking.tailgate
    tailgate.size += @booking.quantity
    tailgate.save

    @booking.destroy

    flash[:danger] = "Booking #{@booking.id} has been deleted"
    redirect_to bookings_url
  end

end
