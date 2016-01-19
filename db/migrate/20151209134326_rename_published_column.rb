class RenamePublishedColumn < ActiveRecord::Migration
  def change
    rename_column :cities, :publihsed, :published
  end
end
