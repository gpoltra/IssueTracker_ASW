class RemoveStatusFromMicroposts < ActiveRecord::Migration[6.0]
  def change

    remove_column :microposts, :status, :string
  end
end
