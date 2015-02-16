class AddDatestringToEvents < ActiveRecord::Migration
  def change
    remove_column :events, :date
    add_column :events, :date, :string
  end
end
