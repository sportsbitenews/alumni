class AddMailchimpListIdToCities < ActiveRecord::Migration
  def change
    add_column :cities, :mailchimp_list_id, :string
    add_column :cities, :mailchimp_api_key, :string
  end
end
