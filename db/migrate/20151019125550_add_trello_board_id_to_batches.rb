class AddTrelloBoardIdToBatches < ActiveRecord::Migration
  def change
    add_column :batches, :trello_board_id, :string
  end
end
