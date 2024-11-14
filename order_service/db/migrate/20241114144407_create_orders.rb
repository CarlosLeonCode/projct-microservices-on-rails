class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.string :product_name
      t.integer :quantity
      t.decimal :price
      t.integer :status

      t.timestamps
    end
  end
end
