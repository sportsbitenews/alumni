class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :user, index: true, foreign_key: true
      t.text :content
      t.integer :answerable_id
      t.string :answerable_type

      t.timestamps null: false
    end
  end
end
