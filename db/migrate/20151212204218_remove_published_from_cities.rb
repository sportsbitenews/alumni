class RemovePublishedFromCities < ActiveRecord::Migration
  def change
    remove_column :cities, :published
  end
end
