class BookingsController < ApplicationController

  def new
    @tailgate = Tailgate.find(params[:id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.new

    @booking.tailgate_id = params[:tailgate_id]
    @booking.quantity = params[:quantity]
    @booking.user_id = current_user.id

    tickets_total = @booking.quantity * Tailgate.find(@booking.tailgate_id).price
    puts "#{tickets_total}"

    taxes = tickets_total * 0.10
    puts "#{taxes}"

    fees = ((tickets_total + taxes)*0.029) + 0.30
    puts "#{fees}"

    @booking.amount = (tickets_total + taxes + fees)

    @booking.process_payment(params[:stripeToken], @booking.amount)

    tailgate = Tailgate.find(@booking.tailgate_id)
    tailgate.size -= @booking.quantity
    tailgate.save

    @booking.save

    redirect_to booking_url(@booking.id)
    # respond_to do |format|
    #   if @booking.save
    #     # Tell the UserMailer to send a welcome email after save
    #     BookingMailer.receipt_email(@booking).deliver_later
    #     format.html { redirect_to @booking }
    #     format.json { render json: @booking, status: :created, location: @booking }
    #   else
    #     format.html { render action: 'bookings/new' }
    #     format.json { render json: @booking.errors, status: :unprocessable_entity }
    #   end
    # end

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

    flash[:danger] = "You've cancelled your tailgate. We're sorry that you can't make it. You will be refunded in 10 business days."
    redirect_to user_url(@booking.user_id)
  end

end
