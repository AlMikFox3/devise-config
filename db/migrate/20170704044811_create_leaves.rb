class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.string :type
      t.integer :duration
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
