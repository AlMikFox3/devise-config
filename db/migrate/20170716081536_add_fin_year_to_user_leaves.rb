class AddFinYearToUserLeaves < ActiveRecord::Migration
  def change
  	add_column :user_leaves, :fin_year, :string, :default => "2017-18"
  end
end
