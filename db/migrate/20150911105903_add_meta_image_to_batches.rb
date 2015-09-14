class AddMetaImageToBatches < ActiveRecord::Migration
  def up
    add_attachment :batches, :meta_image
  end

  def down
    remove_attachment :batches, :meta_image
  end
end
