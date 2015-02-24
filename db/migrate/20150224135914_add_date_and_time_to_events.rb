class AddDateAndTimeToEvents < ActiveRecord::Migration
  def change
    remove_column :events, :date
    add_column :events, :date, :datetime
  end
end
