class RemoveAssociatedEventNameFromTailgates < ActiveRecord::Migration
  def change
    add_column :tailgates, :event_id, :integer
    remove_column :tailgates, :associated_event
  end
end
