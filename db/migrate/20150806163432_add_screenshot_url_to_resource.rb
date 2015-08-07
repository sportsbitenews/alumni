class AddScreenshotUrlToResource < ActiveRecord::Migration
  def change
    add_column :resources, :screenshot_url, :string
  end
end
