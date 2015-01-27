class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean
    add_column :users, :stripe_customer_id, :string
    add_column :users, :host_status, :boolean
    remove_column :users, :stripe_id
  end
end
