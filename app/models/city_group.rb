# == Schema Information
#
# Table name: city_groups
#
#  id         :integer          not null, primary key
#  name       :string
#  slug       :string
#  icon       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CityGroup < ActiveRecord::Base
  has_many :cities, dependent: :nullify
end
