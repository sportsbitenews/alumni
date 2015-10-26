class AddSpecificsToCities < ActiveRecord::Migration
  def change
    add_column :cities, :specifics, :text
  end
end
