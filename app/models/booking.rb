require 'stripe'

class Booking < ActiveRecord::Base
  belongs_to :tailgate
  belongs_to :buyer, :class_name => "User", :foreign_key => "buyer_id"

  def set_buyer(current_user)
    unless checkout_as_guest
      self.buyer = current_user
    end
  end

  def set_amounts_and_fees(params)
    set_ticket_sales

    if ticket_sales > 0
      set_stripe_fees
    end

    self.total_price = ticket_sales + stripe_fees

    process_payment(params[:stripeToken], total_price)

  end

  def set_ticket_sales
    if tailgate.type == "FreeTailgate"
      self.ticket_sales = donation_amount.to_f
    else
      self.ticket_sales = quantity * tailgate.price.to_f
    end
  end

  def set_stripe_fees
    self.stripe_fees = ((ticket_sales*0.029) + 0.30).to_f
  end

  def process_payment(stripe_token, amount)
    Stripe.api_key = ENV['stripe_api_key']

    # TODO: If you keep a rescue like this your code will be like a blackhole
    # it will be really hard to catch the problem. Instead you could save something
    # in the database, for example, in Lantern we store the attempts of charge
    # and the if it fail we record the problem there as well.

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      @charge = Stripe::Charge.create(
        :amount => (amount * 100).to_i, # amount in cents, again
        :currency => "usd",
        :card => stripe_token,
        :description => "payinguser@example.com"
      )

    rescue Stripe::CardError => e
      # The card has been declined
    end

    self.stripe_token = @charge["id"]
  end

  def refund(charge_id)
    Stripe.api_key = ENV['stripe_api_key']
    ch = Stripe::Charge.retrieve(charge_id)
    refund = ch.refunds.create
  end

  def adjust_tailgate_size
    tailgate = self.tailgate
    tailgate.current_size -= self.quantity
    tailgate.save
  end

end
