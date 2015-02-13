class AddTakePercentageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sales_percentage, :decimal, :precision => 6, :scale => 5
  end
end
