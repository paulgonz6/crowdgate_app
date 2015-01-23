require 'stripe'

class Booking < ActiveRecord::Base
  belongs_to :tailgate
  belongs_to :user

  def process_payment(stripe_token, amount)
    Stripe.api_key = "sk_test_Fogj9Y2IHHGTv0vKAHKsxHDW"

    # Get the credit card details submitted by the form
    token = stripe_token

    # Create a Customer
    customer = Stripe::Customer.create( :card => token, :description => "payment for tailgate")

    # Charge the Customer instead of the card
    @charge = Stripe::Charge.create(  :amount => amount * 100,
                                      :currency => "usd",
                                      :customer => customer.id,
                                      :description => "Testing"
                                    )

    self.stripe_token = @charge["id"]

    save_stripe_customer_id(1, customer.id)

  end

  def save_stripe_customer_id(user_id, customer_id)
    user = User.find(user_id)
    user.stripe_id = customer_id
    user.save
  end

  def refund(charge_id)
    Stripe.api_key = "sk_test_Fogj9Y2IHHGTv0vKAHKsxHDW"
    ch = Stripe::Charge.retrieve(charge_id)
    refund = ch.refunds.create
  end

end
