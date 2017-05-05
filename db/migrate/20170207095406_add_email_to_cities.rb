class AddEmailToCities < ActiveRecord::Migration[5.0]
  def change
    add_column :cities, :email, :string
    City.transaction do
      {
        "tokyo" => "tokyo@lewagon.org",
        "berlin" => "berlin@lewagon.org",
        "rio" => "rio@lewagon.org",
        "barcelona" => "barcelona@lewagon.org",
        "sao-paulo" => "sao-paulo@lewagon.org",
        "london" => "london@lewagon.org",
        "copenhagen" => "copenhagen@lewagon.org",
        "nantes" => "nantes@lewagon.org",
        "amsterdam" => "amsterdam@lewagon.org",
        "lisbon" => "lisbon@lewagon.org",
        "aix-marseille" => "marseille@lewagon.org",
        "bordeaux" => "bordeaux@lewagon.org",
        "lille" => "lille@lewagon.org",
        "brussels" => "brussels@lewagon.org",
        "lyon" => "lyon@lewagon.org",
        "montreal" => "montreal@lewagon.org",
        "shanghai" => "shanghai@lewagon.org"
      }.each do |slug, email|
        city = City.find_by_slug slug
        raise ActiveRecord::RecordNotFound.new("Could not find city #{slug}") if city.nil?
        city.update(email: email)
      end
    end
  end
end
