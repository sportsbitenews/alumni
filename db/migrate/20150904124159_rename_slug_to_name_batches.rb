class RenameSlugToNameBatches < ActiveRecord::Migration
  def change
    rename_column :batches, :name, :slug
  end
end
