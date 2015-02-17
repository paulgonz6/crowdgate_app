class AddOriginalSizeToTailgate < ActiveRecord::Migration
  def change
    add_column :tailgates, :original_size, :integer
    add_column :tailgates, :current_size, :integer
    remove_column :tailgates, :size
  end
end
