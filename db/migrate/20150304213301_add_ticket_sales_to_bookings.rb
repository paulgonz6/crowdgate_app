class AddTicketSalesToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :ticket_sales, :decimal, :precision => 10, :scale => 4, :default => 0
  end
end
