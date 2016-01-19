class AddNoIndexToUsers < ActiveRecord::Migration
  def change
    add_column :users, :noindex, :boolean, default: false, null: false
  end
end
