class RemoveAttachmentFileSizeFromMicroposts < ActiveRecord::Migration[6.0]
  def change

    remove_column :microposts, :attachment_file_size, :integer
  end
end
