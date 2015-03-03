class ChangeColumnUserIdToHostTailgates < ActiveRecord::Migration
  def change
    remove_column :tailgates, :user_id
    add_column    :tailgates, :host_id, :integer
  end
end
