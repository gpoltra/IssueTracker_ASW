class DropWatchers < ActiveRecord::Migration[6.0]
  def change
    drop_table :watchers
  end
end
