class AddTimeZoneToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :time_zone, :string, default: 'Paris'
  end
end
