class AddAttachmentToIssues < ActiveRecord::Migration[6.0]
  def self.up
    change_table :microposts do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :microposts, :attachment
  end
end
