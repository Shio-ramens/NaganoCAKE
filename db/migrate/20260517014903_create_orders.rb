class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :postal_code
      t.string :address
      t.string :name
      t.integer :payment_method
      t.integer :total_payment
      t.integer :status

      t.timestamps
    end
  end
end
