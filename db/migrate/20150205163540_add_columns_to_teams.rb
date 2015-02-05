class AddColumnsToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :logo, :string
    add_column :teams, :color, :string
  end
end
