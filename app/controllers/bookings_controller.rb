class BookingsController < ApplicationController
  before_action :set_booking, :only => [:show, :destroy]
  before_action :set_tailgate, :only => [:new, :show, :create]

  def new
    @booking = Booking.new(:tailgate => @tailgate)
    @stripe_key = set_stripe_publishable_key
  end

  def create
    unless current_user.present?
      @new_user = User.create(user_params)
    end

    @booking = Booking.new(booking_params)

    if @booking.email.present? || current_user.present?
      @booking.save
      status = @booking.process_booking(@tailgate,current_user,params[:stripeToken])
      if status.nil?
        @booking.save
        BookingMailer.guest_receipt(@booking).deliver
        BookingMailer.admin_booking_notification(@booking).deliver
        BookingMailer.host_alert(@booking).deliver
        redirect_to tailgate_booking_url(@booking.tailgate_id, @booking.id)
      else
        flash[:danger] = "#{status}"
        redirect_to :back
      end

    else
      flash[:danger] = "Please include an email address."
      redirect_to :back
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

    def user_params
      params.require(:user).permit(:email, :phone, :password, :password_confirmation)
    end

end
