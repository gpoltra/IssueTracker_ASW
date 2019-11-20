class RemoveWatchersFromMicroposts < ActiveRecord::Migration[6.0]
  def change

    remove_column :microposts, :watchers, :integer
  end
end
