class FixSchool < ActiveRecord::Migration
  def change
    rename_column :users, :studies, :school
    change_column :users, :school,  :string
  end
end
