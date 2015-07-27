class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fist_name, :string
    add_column :users, :last_name, :string
    add_column :users, :alumni, :boolean, default: false, null: false
    add_column :users, :admin, :boolean, default: false, null: false
    add_column :users, :teacher_assistant, :boolean, default: false, null: false
    add_column :users, :teacher, :boolean, default: false, null: false
    add_reference :users, :batch, index: true, foreign_key: true
  end
end
