class AddColumnToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :votes, :integer, :null => false, :default => 0
  end
end
