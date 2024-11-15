class CreateCustomers < ActiveRecord::Migration[7.2]
  def change
    create_table :customers do |t|
      t.string :customer_name
      t.string :address
      t.integer :orders_count

      t.timestamps
    end
  end
end
