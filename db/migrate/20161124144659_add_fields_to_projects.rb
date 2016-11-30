class AddFieldsToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :demoday_timestamp, :integer
    add_column :projects, :technos, :text, array: true, default: []
  end
end
