class AddCompanyNatureToCities < ActiveRecord::Migration
  def change
    add_column :cities, :company_nature, :string
  end
end
