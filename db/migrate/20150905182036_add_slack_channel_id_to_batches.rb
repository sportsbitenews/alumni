class AddSlackChannelIdToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :slack_id, :string
  end
end
