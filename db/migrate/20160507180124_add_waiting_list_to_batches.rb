class AddWaitingListToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :waiting_list, :boolean, default: false, null: false
  end
end
