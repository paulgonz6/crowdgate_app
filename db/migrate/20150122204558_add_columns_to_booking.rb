class AddColumnsToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :user_id,           :integer
    add_column :bookings, :valid_transaction, :boolean, :default => false
    add_column :bookings, :tailgate_id,       :integer
  end
end
