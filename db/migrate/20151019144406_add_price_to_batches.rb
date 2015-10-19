class AddPriceToBatches < ActiveRecord::Migration
  def change
    add_monetize :batches, :price
  end
end
