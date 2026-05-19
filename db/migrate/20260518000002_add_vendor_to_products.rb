class AddVendorToProducts < ActiveRecord::Migration[8.1]
  def change
    add_reference :products, :vendor, foreign_key: { to_table: :users }, null: true
  end
end
