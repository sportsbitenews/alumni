class AddAttachmentCoverPictureToProjects < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.attachment :cover_picture
    end
  end

  def self.down
    remove_attachment :projects, :cover_picture
  end
end
