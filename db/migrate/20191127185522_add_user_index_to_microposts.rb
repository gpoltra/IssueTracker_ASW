class AddUserIndexToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_index :microposts, [:user_id]
  end
end
