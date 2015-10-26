class ChangeDefaultCurrencyToEur < ActiveRecord::Migration
  def change
    change_column :batches, :price_currency, :string, default: 'EUR', null: false
  end
end
