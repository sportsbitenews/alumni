class AddCompanyNameToCities < ActiveRecord::Migration
  def change
    add_column :cities, :company_name, :string
  end
end
