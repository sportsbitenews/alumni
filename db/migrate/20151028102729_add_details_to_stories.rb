class AddDetailsToStories < ActiveRecord::Migration
  def change
    add_column :stories, :title_en, :string
    add_column :stories, :title_fr, :string
    add_column :stories, :summary_fr, :text
    add_column :stories, :summary_en, :text
  end
end
