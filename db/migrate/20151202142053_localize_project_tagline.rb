class LocalizeProjectTagline < ActiveRecord::Migration
  def change
    rename_column :projects, :tagline, :tagline_en
    add_column :projects, :tagline_fr, :string
  end
end
