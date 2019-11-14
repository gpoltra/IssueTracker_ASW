class AddPriorityToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :priority, :string
    remove_column :microposts, :type
  end
end
