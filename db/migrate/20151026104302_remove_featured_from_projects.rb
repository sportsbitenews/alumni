class RemoveFeaturedFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :featured, :boolean
  end
end
