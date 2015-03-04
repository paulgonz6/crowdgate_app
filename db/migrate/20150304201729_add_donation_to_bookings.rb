class AddDonationToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :stripe_fees, :decimal, :precision => 10, :scale => 4, :default => 0
    add_column :bookings, :total_price, :decimal, :precision => 10, :scale => 4, :default => 0
    add_column :bookings, :donation_amount, :decimal, :precision => 10, :scale => 4, :default => 0
    add_column :bookings, :buyer_id, :integer
    add_column :bookings, :email, :string
    add_column :bookings, :phone, :string
    add_column :bookings, :checkout_as_guest, :boolean

    remove_column :bookings, :user_id
    remove_column :bookings, :valid_transaction
    remove_column :bookings, :amount
  end
end
