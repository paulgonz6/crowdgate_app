require 'stripe'

class Booking < ActiveRecord::Base
  belongs_to :tailgate
  belongs_to :user

  def process_payment(stripe_token, amount)
    Stripe.api_key = "sk_test_Fogj9Y2IHHGTv0vKAHKsxHDW"

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      @charge = Stripe::Charge.create(
        :amount => amount * 100, # amount in cents, again
        :currency => "usd",
        :card => stripe_token,
        :description => "payinguser@example.com"
      )

    rescue Stripe::CardError => e
      # The card has been declined
    end

    self.stripe_token = @charge["id"]
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

  def send_mailer
  end


end
