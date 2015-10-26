class RemoveActiveFromCities < ActiveRecord::Migration
  def change
    remove_column :cities, :active, :boolean
  end
end
