class AddDetailsToTailgates < ActiveRecord::Migration
  def change
    add_column :tailgates, :reserved_parking, :boolean
    add_column :tailgates, :grill, :boolean
    add_column :tailgates, :tent, :boolean
  end
end
