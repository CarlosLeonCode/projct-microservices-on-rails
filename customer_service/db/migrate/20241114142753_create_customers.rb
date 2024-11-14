class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.string :name
      t.integer :orders_count, :default =>  0
      t.string :address

      t.timestamps
    end
  end
end
