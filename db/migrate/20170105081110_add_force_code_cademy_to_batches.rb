class AddForceCodeCademyToBatches < ActiveRecord::Migration[5.0]
  def change
    add_column :batches, :force_completed_codecademy_at_apply, :boolean, default: false
  end
end
