class AddSlackChannelIdToCities < ActiveRecord::Migration
  def change
    add_column :cities, :slack_channel_id, :string
    city_channel_ids = {
      "aix-marseille" => "C0JBQ0SKS",
      "amsterdam" => "C0JBHR1JQ",
      "beirut" => "C0JBNPFR7",
      "bordeaux" => "C0RGB2CU9",
      "brussels" => "C0FNMM7FG",
      "lille" => "C0KAU6ASJ",
      "lisbon" => "C0JBNPUSV",
      "london" => "C0UHVH1T6",
      "paris" => "C0FN76L7N"
    }
    city_channel_ids.each do |slug, channel_id|
      city = City.find_by(slug: slug)
      if city
        city.slack_channel_id = channel_id
        city.save
      end
    end
  end
end
