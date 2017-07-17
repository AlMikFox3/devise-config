class AddFinYearToLeaves < ActiveRecord::Migration
  def change
  	add_column :leaves, :fin_year, :string, :default => "2017-18"
  end
end
