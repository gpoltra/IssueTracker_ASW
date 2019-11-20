class AddVotesToMicropost < ActiveRecord::Migration[6.0]
  def change
    add_column :microposts, :votes, :integer, {default:0}
  end
end
