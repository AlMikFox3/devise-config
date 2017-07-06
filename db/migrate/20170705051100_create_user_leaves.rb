class CreateUserLeaves < ActiveRecord::Migration
  def change
    create_table :user_leaves do |t|
      t.integer :user_id
      t.string :leave_type
      t.integer :leave_left, :default => 5
      t.integer :leave_taken, :default => 0

      t.timestamps null: false
    end
  end
end
