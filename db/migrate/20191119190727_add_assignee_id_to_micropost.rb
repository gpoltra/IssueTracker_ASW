class AddAssigneeIdToMicropost < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :assignee_id, :integer
  end
end
