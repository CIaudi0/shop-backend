class CleanUpSchema < ActiveRecord::Migration[8.1]
  def change
    remove_column :orders, :items, :jsonb

    change_column_null :cart_items, :quantity, false, 1
    change_column_default :cart_items, :quantity, from: nil, to: 1

    change_column_null :order_items, :quantity, false, 1
  end
end
