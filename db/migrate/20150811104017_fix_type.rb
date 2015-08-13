class FixType < ActiveRecord::Migration
  def change
    rename_column :jobs, :type, :contract

  end
end
