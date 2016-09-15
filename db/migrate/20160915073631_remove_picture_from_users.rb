class RemovePictureFromUsers < ActiveRecord::Migration
  def change
    remove_attachment :users, :picture
  end
end
