class AddTrainingAddressToCities < ActiveRecord::Migration
  def change
    add_column :cities, :training_address, :string
  end
end
