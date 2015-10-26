class CreateOrderedLists < ActiveRecord::Migration
  def change
    create_table :ordered_lists do |t|
      t.string :name
      t.string :element_type
      t.text :slugs, array: true, default: []

      t.timestamps null: false
    end
  end
end
