class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.text :description_en
      t.text :description_fr
      t.boolean :published, default: false, null: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
