class AddAttachmentClassroomPictureToCities < ActiveRecord::Migration
  def self.up
    change_table :cities do |t|
      t.attachment :classroom_picture
    end
  end

  def self.down
    remove_attachment :cities, :classroom_picture
  end
end
