class AddCompanyPurposeAndRegistrationToCities < ActiveRecord::Migration
  def change
    add_column :cities, :company_purpose_and_registration, :string
  end
end
