class ChangeColumnsInReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :user_id, :integer
    remove_column :reviews, :reviewer_id
  end
end
