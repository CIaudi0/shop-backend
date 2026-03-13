class CreateOrders < ActiveRecord::Migration[8.1]
  def change
    create_table :orders do |t|
      t.jsonb :customer
      t.jsonb :address
      t.jsonb :items
      t.decimal :total

      t.timestamps
    end
  end
end
