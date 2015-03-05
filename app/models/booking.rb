require 'stripe'

class Booking < ActiveRecord::Base
  belongs_to :tailgate
  belongs_to :buyer, :class_name => "User", :foreign_key => "buyer_id"

  def process_booking(tailgate,buyer,stripe_token)
    self.tailgate = tailgate
    set_buyer(buyer)

    error = nil
    tailgate.transaction do
      if tailgate.adjust_size(quantity)
        unless set_amounts_and_fees(stripe_token)
          error = "Error charging the card"
        end
      else
        error = "You just missed it! We no longer have that many tickets available."
      end

      raise ActiveRecord::Rollback unless error.nil?
    end

    return error
  end

  def set_buyer(current_user)
    unless checkout_as_guest
      self.buyer = current_user
    end
  end

  def set_amounts_and_fees(stripe_token)
    set_ticket_sales
    if ticket_sales > 0
      set_stripe_fees
    end
    self.total_price = ticket_sales + stripe_fees
    process_stripe_charge(stripe_token, total_price, set_description)
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

  def set_description
    buyer.present? ? email = self.buyer.email : email = self.email
    event = self.tailgate.event.name
    tailgate = self.tailgate_id
    return "#{email} bought a ticket for tailgate ##{tailgate}, at #{event}. Confirmation number is #{self.id}."
  end

  def process_stripe_charge(stripe_token, amount, description)
    Stripe.api_key = ENV['stripe_api_key']

    begin
      @charge = Stripe::Charge.create(
        :amount => (amount * 100).to_i,
        :currency => "usd",
        :card => stripe_token,
        :description => description
      )
      self.stripe_token = @charge["id"]
      return true

    rescue Stripe::CardError => e
      return e.message

    rescue => e
      return false
    end

  end

  def refund(charge_id)
    Stripe.api_key = ENV['stripe_api_key']
    ch = Stripe::Charge.retrieve(charge_id)
    refund = ch.refunds.create
  end

end
