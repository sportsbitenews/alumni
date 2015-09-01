class AddStudiesToUser < ActiveRecord::Migration
  def change
    add_column :users, :school, :string
  end
end
