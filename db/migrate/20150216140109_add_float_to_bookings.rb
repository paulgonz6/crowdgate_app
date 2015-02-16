class AddFloatToBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :amount
    add_column :bookings, :amount, :decimal, :precision => 6, :scale => 5
  end
end
