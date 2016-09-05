class AddGroupReferenceToCities < ActiveRecord::Migration
  def change
    add_reference :cities, :city_group, index: true, foreign_key: true
    # associate French cities to france's city group
    france_slugs = %w(paris bordeaux lille aix-marseille nantes)
    france = CityGroup.find_by(slug: "france")
    france_slugs.each do |slug|
      city = City.find_by(slug: slug)
      city.city_group = france
      city.save!
    end

    # create French cities ordered list
    france_ordered_list = OrderedList.create!(
      name: "france_official_cities",
      element_type: "City",
      slugs: france_slugs
    )

    # associate European cities to europe's city group
    europe_slugs = %w(london amsterdam brussels lisbon copenhagen barcelona beirut)
    europe = CityGroup.find_by(slug: "europe")
    europe_slugs.each do |slug|
      city = City.find_by(slug: slug)
      city.city_group = europe
      city.save!
    end

    # create European cities ordered list
    europe_ordered_list = OrderedList.create!(
      name: "europe_official_cities",
      element_type: "City",
      slugs: europe_slugs
    )

    # associate Brazilian cities to brazil's city group
    brazil_slugs = %w(sao-paulo belo-horizonte)
    brazil = CityGroup.find_by(slug: "brazil")
    brazil_slugs.each do |slug|
      city = City.find_by(slug: slug)
      city.city_group = brazil
      city.save!
    end

    # create Brazilian cities ordered list
    brazil_ordered_list = OrderedList.create!(
      name: "brazil_official_cities",
      element_type: "City",
      slugs: brazil_slugs
    )
  end

end
