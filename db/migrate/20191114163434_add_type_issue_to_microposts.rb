class AddTypeIssueToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :type_issue, :string
  end
end
