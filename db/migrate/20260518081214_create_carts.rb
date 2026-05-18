class CreateCarts < ActiveRecord::Migration[8.0]
  def change
    create_table :carts do |t|
      t.references :item, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.integer :amount, null: false, default: 1

      t.timestamps
    end
  end
end
