# == Schema Information
#
# Table name: batches
#
#  id         :integer          not null, primary key
#  name       :string
#  city_id    :integer
#  starts_at  :date
#  ends_at    :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_batches_on_city_id  (city_id)
#

class Batch < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  belongs_to :city
  has_many :users
end
