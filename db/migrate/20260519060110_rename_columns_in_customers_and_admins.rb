class RenameColumnsInCustomersAndAdmins < ActiveRecord::Migration[8.0]
def change
    rename_column :customers, :email, :email
    rename_column :customers, :encrypted_password, :encrypted_password

    rename_column :admins, :email, :email
    rename_column :admins, :encrypted_password, :encrypted_password
  end
end
