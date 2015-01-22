class AddUserToTailgates < ActiveRecord::Migration
  def change
    add_column :tailgates, :user_id, :integer
  end
end
