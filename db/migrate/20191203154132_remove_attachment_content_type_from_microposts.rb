class RemoveAttachmentContentTypeFromMicroposts < ActiveRecord::Migration[6.0]
  def change

    remove_column :microposts, :attachment_content_type, :string
  end
end
