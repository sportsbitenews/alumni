class AddBatchTeachers < ActiveRecord::Migration
  def change
    create_table :batches_users, id: false do |t|
      t.belongs_to :batch, index: true
      t.belongs_to :user, index: true
    end
  end
end
