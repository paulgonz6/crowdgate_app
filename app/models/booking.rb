require 'stripe'

class Booking < ActiveRecord::Base
  belongs_to :tailgate
  belongs_to :buyer, :class_name => "User", :foreign_key => "user_id"

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

  # TODO: Looks like you are not using this method but if you do I would move it
  # to the user model (or even call user.stripe_id = customer_id straigh from the controllers)
  def save_stripe_customer_id(user_id, customer_id)
    user = User.find(user_id)
    user.stripe_id = customer_id
    user.save
  end

  def refund(charge_id)
    # TODO: You shouldn't keep keys in your code, take a look on how to use the secret.yml and env vars
    # Reference links:
    # ENV Vars on Heroku https://devcenter.heroku.com/articles/config-vars
    # secrets.yml http://edgeguides.rubyonrails.org/upgrading_ruby_on_rails.html#config-secrets-yml
    Stripe.api_key = "sk_test_Fogj9Y2IHHGTv0vKAHKsxHDW"
    ch = Stripe::Charge.retrieve(charge_id)
    refund = ch.refunds.create
  end

  def send_mailer
  end


end
