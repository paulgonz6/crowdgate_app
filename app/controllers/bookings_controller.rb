class BookingsController < ApplicationController

  def new
    @tailgate = Tailgate.find(params[:id])
  end

  def create
    @booking = Booking.new
    @booking.tailgate_id = params[:tailgate_id]
    @booking.stripe_token = params[:stripeToken]
    @booking.save

    # Set your secret key: remember to change this to your live secret key in production
    # See your keys here https://dashboard.stripe.com/account
    Stripe.api_key = "sk_test_Fogj9Y2IHHGTv0vKAHKsxHDW"

    # Get the credit card details submitted by the form
    token = params[:stripeToken]

    # Create a Customer
    customer = Stripe::Customer.create(
      :card => token,
      :description => "test payments examples"
      )

    puts customer.id

    # Save the customer ID in your database so you can use it later
    user = User.find(1)
    user.stripe_id = customer.id
    user.save

    # Charge the Customer instead of the card
    Stripe::Charge.create(
        :amount => 100, # in cents
        :currency => "usd",
        :customer => customer.id
        )

    redirect_to booking_url(@booking.id)
  end

  def show
    @booking = Booking.find(params[:id])
    # @tailgate = Tailgate.find(params[:id])
    # @tailgate.size -= params[:quantity].to_i
    # @tailgate.save
  end

end
