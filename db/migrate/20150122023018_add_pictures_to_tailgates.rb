class AddPicturesToTailgates < ActiveRecord::Migration
  def change
    add_column :tailgates, :image_1, :string
    add_column :tailgates, :image_2, :string
    add_column :tailgates, :image_3, :string
    add_column :tailgates, :image_4, :string
  end
end
