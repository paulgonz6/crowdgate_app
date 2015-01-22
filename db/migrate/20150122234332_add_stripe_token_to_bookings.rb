class AddStripeTokenToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :stripe_token, :string
  end
end
