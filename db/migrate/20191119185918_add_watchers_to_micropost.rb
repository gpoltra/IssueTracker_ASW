class AddWatchersToMicropost < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :watchers, :integer
  end
end
