class AddCityOwners < ActiveRecord::Migration
  def change
    create_table :cities_users, id: false do |t|
      t.belongs_to :city, index: true
      t.belongs_to :user, index: true
    end
  end
end
