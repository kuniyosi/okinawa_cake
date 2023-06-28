class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|

      t.integer :customer_id,   null: false
      t.integer :menu_id,       null: false
      t.integer :item_quantity, null: false

      t.timestamps
    end
  end
end
