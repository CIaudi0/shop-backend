class AddUserAndStatusToOrders < ActiveRecord::Migration[8.1]
  def change
    add_reference :orders, :user, null: false, foreign_key: true
    add_column :orders, :status, :string
  end
end
