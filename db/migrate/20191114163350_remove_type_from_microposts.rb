class RemoveTypeFromMicroposts < ActiveRecord::Migration[6.0]
  def change

    remove_column :microposts, :type, :string
  end
end
