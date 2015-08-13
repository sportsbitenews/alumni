class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :company
      t.string :position
      t.string :ad_url
      t.string :contact_email
      t.string :city
      t.boolean :remote
      t.string :type
      t.text :description

      t.timestamps null: false
    end
  end
end
