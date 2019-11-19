class AddStatusToMicropost < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :status, :string
  end
end
