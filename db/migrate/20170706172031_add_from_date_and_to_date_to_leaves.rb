class AddFromDateAndToDateToLeaves < ActiveRecord::Migration
  def change
  	add_column :leaves, :from_date, :date
  	add_column :leaves, :to_date, :date
  end
end
