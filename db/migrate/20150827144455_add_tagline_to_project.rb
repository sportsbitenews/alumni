class AddTaglineToProject < ActiveRecord::Migration
  def change
    add_column :projects, :tagline, :string
  end
end
