class FixFistName < ActiveRecord::Migration
  def change
    rename_column :users, :first_name, :first_name
  end
end
