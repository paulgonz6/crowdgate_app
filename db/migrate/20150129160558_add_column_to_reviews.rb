class AddColumnToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :tailgate_id, :integer
    remove_column :reviews, :user_id
  end
end
