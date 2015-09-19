class AddAttachmentLocationPictureToCities < ActiveRecord::Migration
  def self.up
    change_table :cities do |t|
      t.attachment :location_picture
    end
  end

  def self.down
    remove_attachment :cities, :location_picture
  end
end
