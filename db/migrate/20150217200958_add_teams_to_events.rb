class AddTeamsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :away_team_id, :integer
    add_column :events, :home_team_id, :integer
    add_column :events, :type, :string
  end
end
