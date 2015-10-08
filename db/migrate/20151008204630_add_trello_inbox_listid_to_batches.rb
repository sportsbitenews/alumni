class AddTrelloInboxListidToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :trello_inbox_list_id, :string
  end
end
