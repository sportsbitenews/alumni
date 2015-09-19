class AddInfosToCity < ActiveRecord::Migration
  def change
    add_column :cities, :location, :string
    add_column :cities, :address, :string
    add_column :cities, :description_fr, :text
    add_column :cities, :description_en, :text
    add_column :cities, :meetup_id, :integer
    add_column :cities, :twitter_url, :string
    add_column :cities, :active, :boolean, default: false, null: false
  end
end
