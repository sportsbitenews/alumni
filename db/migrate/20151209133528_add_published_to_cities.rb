class AddPublishedToCities < ActiveRecord::Migration
  def change
    add_column :cities, :publihsed, :boolean, null: false, default: true
  end
end
