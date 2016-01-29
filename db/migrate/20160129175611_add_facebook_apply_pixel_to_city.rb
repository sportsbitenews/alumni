class AddFacebookApplyPixelToCity < ActiveRecord::Migration
  def change
    remove_column :batches, :apply_facebook_pixel
    add_column :cities, :apply_facebook_pixel, :string
  end
end
