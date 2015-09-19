class AddBioToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bio_en, :text
    add_column :users, :bio_fr, :text
  end
end
