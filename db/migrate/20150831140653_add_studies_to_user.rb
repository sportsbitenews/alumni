class AddStudiesToUser < ActiveRecord::Migration
  def change
    add_column :users, :studies, :text
  end
end
