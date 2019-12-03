class AddWatchersToMicropost < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :Watchers, :integer, {default:0}
  end
end

