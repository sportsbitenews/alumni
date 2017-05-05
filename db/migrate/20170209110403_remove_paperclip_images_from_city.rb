class RemovePaperclipImagesFromCity < ActiveRecord::Migration[5.0]
  def self.up
    remove_attachment :cities, :city_picture
    remove_attachment :cities, :classroom_picture
    remove_attachment :cities, :location_picture
  end

  def self.down
    change_table :cities do |t|
      t.attachment :city_picture
      t.attachment :classroom_picture
      t.attachment :location_picture
    end
  end
end
