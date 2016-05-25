class RenameSpecificsIntoLogisticSpecificsInCities < ActiveRecord::Migration
  def change
    rename_column :cities, :specifics, :logistic_specifics
  end
end
