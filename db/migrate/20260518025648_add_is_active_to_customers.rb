class AddIsActiveToCustomers < ActiveRecord::Migration[8.0]
  def change
    add_column :customers, :is_active, :boolean, default: true, null: false
  end
end
