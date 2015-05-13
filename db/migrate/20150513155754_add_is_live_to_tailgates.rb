class AddIsLiveToTailgates < ActiveRecord::Migration
  def change
    add_column :tailgates, :live, :boolean, :default => true
  end
end
