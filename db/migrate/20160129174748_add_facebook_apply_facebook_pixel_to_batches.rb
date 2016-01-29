class AddFacebookApplyFacebookPixelToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :apply_facebook_pixel, :string
  end
end
