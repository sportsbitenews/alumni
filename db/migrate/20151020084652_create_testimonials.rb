class CreateTestimonials < ActiveRecord::Migration
  def change
    create_table :testimonials do |t|
      t.references :user, index: true, foreign_key: true
      t.string :content
      t.string :locale

      t.timestamps null: false
    end
  end
end
