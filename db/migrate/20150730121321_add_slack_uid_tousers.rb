class AddSlackUidTousers < ActiveRecord::Migration
  def change
    add_column :users, :slack_uid, :string
  end
end
