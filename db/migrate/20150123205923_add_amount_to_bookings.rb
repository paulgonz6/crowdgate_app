class AddAmountToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :quantity, :integer
    add_column :bookings, :amount, :integer
  end
end
