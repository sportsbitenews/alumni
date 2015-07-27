class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.string :name
      t.references :city, index: true, foreign_key: true
      t.date :starts_at
      t.date :ends_at

      t.timestamps null: false
    end
  end
end
