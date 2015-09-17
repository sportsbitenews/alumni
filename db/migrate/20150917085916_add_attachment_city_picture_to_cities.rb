class AddAttachmentCityPictureToCities < ActiveRecord::Migration
  def self.up
    change_table :cities do |t|
      t.attachment :city_picture
    end
  end

  def self.down
    remove_attachment :cities, :city_picture
  end
end
