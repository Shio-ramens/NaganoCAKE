class RenameCartsToCartItems < ActiveRecord::Migration[8.0]
  def change
    rename_table :carts, :cart_items
  end
end
