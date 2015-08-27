# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class City < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :batches
  has_and_belongs_to_many :users
end
