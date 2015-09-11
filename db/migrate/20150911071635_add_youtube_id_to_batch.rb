class AddYoutubeIdToBatch < ActiveRecord::Migration
  def change
    add_column :batches, :youtube_id, :string
    add_column :batches, :live, :bool, default: false, null: false
  end
end
