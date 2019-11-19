class RemoveAssigneeIdFromMicropost < ActiveRecord::Migration[6.0]
  def change

    remove_column :microposts, :assignee_id, :string
  end
end
