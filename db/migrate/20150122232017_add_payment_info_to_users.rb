class AddPaymentInfoToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :stripe_id
    add_column :users, :stripe_id, :string
  end
end
