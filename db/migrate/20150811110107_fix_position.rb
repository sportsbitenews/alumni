class FixPosition < ActiveRecord::Migration
  def change
    rename_column :jobs, :position, :title
  end
end
