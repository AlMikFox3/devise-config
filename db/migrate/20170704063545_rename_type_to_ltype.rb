class RenameTypeToLtype < ActiveRecord::Migration
  def change
  	rename_column :leaves, :type, :ltype
  end
end
