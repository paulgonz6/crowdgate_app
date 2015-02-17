class AddTypeToTailgates < ActiveRecord::Migration
  def change
    add_column :tailgates, :type, :string
  end
end
