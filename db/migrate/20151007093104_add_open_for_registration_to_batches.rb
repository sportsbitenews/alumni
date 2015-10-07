class AddOpenForRegistrationToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :open_for_registration, :boolean, default: false, null: false
  end
end
