class CreateTailgates < ActiveRecord::Migration
  def change
    create_table :tailgates do |t|
      t.string :name
      t.text :description
      t.integer :size
      t.integer :price
      t.string :affiliation
    end
  end
end
