class RemoveAttachmentUpdatedAtFromMicroposts < ActiveRecord::Migration[6.0]
  def change

    remove_column :microposts, :attachment_updated_at, :datetime
  end
end
