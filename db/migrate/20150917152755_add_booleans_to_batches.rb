class AddBooleansToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :last_seats, :boolean, default: false, null: false
    add_column :batches, :full, :boolean, default: false, null: false
  end
end
