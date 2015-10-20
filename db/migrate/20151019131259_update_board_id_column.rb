class UpdateBoardIdColumn < ActiveRecord::Migration
  def change
    rename_column :batches, :trello_board_id, :trello_inbox_list_id
  end
end
