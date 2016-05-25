class AddMarketingSpecificsToCities < ActiveRecord::Migration
  def change
    add_column :cities, :marketing_specifics, :text
  end
end
