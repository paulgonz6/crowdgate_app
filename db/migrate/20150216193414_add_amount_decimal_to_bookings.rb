class AddAmountDecimalToBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :amount
    add_column :bookings, :amount, :decimal, :precision => 10, :scale => 4
  end
end
