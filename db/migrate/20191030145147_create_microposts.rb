class CreateMicroposts < ActiveRecord::Migration[6.0]
  def change
    create_table :microposts do |t|
      t.text :title
      t.text :description
      t.integer :user_id
      t.text :type
      t.text :priority

      t.timestamps
    end
  end
end
