class AddCompanyHqToCities < ActiveRecord::Migration
  def change
    add_column :cities, :company_hq, :string
  end
end
