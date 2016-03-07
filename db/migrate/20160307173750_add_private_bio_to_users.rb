class AddPrivateBioToUsers < ActiveRecord::Migration
  def change
    add_column :users, :private_bio, :text
  end
end
