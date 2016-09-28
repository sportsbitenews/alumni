class AddKittIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :kitt_id, :integer
  end
end
