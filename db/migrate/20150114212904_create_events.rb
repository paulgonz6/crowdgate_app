class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :date
      t.string :time
      t.string :venue
      t.string :city
      t.string :state
      t.string :ap_id
      t.string :api_modified
    end
  end
end
