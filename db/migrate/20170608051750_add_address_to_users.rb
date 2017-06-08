class AddAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address, :string
    add_column :users, :phone, :string
  end
end
