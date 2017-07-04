class AddStatusToLeave < ActiveRecord::Migration
  def change
  	add_column :leaves, :approval, :boolean, :default => false
  end
end
