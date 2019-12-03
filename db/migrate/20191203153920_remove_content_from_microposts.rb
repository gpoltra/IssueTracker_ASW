class RemoveContentFromMicroposts < ActiveRecord::Migration[6.0]
  def change

    remove_column :microposts, :content, :text
  end
end
