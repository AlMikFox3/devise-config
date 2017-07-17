class AddManagerEmailToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :manager_email, :string, :default => 's1@gmail.com'
  end
end
