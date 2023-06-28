class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.integer :customer_id,     null: false
      t.integer :total_price,     null: false
      t.integer :freight,         null: false
      t.integer :status,          null: false
      t.string :ship_name,        null: false
      t.string :ship_to_address,  null: false
      t.integer :postcode,        null: false
      t.integer :payment_method,  null: false

      t.timestamps
    end
  end
end
