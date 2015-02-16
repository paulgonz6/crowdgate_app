class AddDatetimeToEvents < ActiveRecord::Migration
  def change
    remove_column :events, :date
    add_column :events, :date, :timestamp
  end
end
