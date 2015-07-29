class RemoveContentFromResource < ActiveRecord::Migration
  def change
    remove_column :resources, :content, :text
    add_column :resources, :tagline, :string
  end
end
