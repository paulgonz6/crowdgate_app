class AddRatingsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :review, :text
    add_column :reviews, :rating, :integer
    add_column :reviews, :user_id, :integer
    add_column :reviews, :reviewer_id, :integer
  end
end
