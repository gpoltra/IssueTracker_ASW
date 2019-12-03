class RemoveAttachmentFileNameFromMicroposts < ActiveRecord::Migration[6.0]
  def change

    remove_column :microposts, :attachment_file_name, :string
  end
end
