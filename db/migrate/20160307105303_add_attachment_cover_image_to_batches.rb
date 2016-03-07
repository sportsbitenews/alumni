class AddAttachmentCoverImageToBatches < ActiveRecord::Migration
  def self.up
    change_table :batches do |t|
      t.attachment :cover_image
    end
  end

  def self.down
    remove_attachment :batches, :cover_image
  end
end
