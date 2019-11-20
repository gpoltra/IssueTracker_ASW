class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: true
      t.references :micropost, foreign_key: true
    end
  end
end
