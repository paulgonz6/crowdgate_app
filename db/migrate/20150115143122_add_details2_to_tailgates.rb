class AddDetails2ToTailgates < ActiveRecord::Migration
  def change
    add_column :tailgates, :tailgate_start_time, :string
    add_column :tailgates, :tailgate_during_game, :boolean
    add_column :tailgates, :associated_event, :string
    add_column :tailgates, :chairs, :boolean
    add_column :tailgates, :table, :boolean
    add_column :tailgates, :bevs_alcohol, :boolean
    add_column :tailgates, :bevs_non_alcohol, :boolean
    add_column :tailgates, :tailgate_games, :boolean
    add_column :tailgates, :food, :boolean
  end
end
