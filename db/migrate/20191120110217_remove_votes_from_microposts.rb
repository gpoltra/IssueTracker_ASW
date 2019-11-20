class RemoveVotesFromMicroposts < ActiveRecord::Migration[6.0]
  def change

    remove_column :microposts, :votes, :integer
  end
end
