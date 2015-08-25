class FixFistName < ActiveRecord::Migration
  def change
    rename_column :users, :fist_name, :first_name
  end
end
