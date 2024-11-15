class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.string :product_name
      t.integer :quantity
      t.decimal :price
      t.integer :status
      t.integer :customer_id

      t.timestamps
    end
  end
end
