class AddDescriptionToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :description, :string
  end
end
