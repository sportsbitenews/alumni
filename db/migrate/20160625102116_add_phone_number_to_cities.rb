class AddPhoneNumberToCities < ActiveRecord::Migration
  def change
    add_column :cities, :contact_phone_number, :string
    add_column :cities, :contact_phone_number_displayed, :boolean, default: false, null: false
    add_column :cities, :contact_phone_number_name, :string
  end
end
