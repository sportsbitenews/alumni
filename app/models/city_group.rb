class CityGroup < ActiveRecord::Base
  has_many :cities, dependent: :nullify
end
