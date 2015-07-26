# == Schema Information
#
# Table name: resources
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  url        :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_resources_on_user_id  (user_id)
#

class Resource < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true
  validates :url, presence: true, url: true, uniqueness: true
  validates :user, presence: true
  acts_as_votable

  has_many :answers, as: :answerable

  # TODO(ssaunier): compute on-the-fly score for a resource
  # score = function(x is days passed since created_at, votes) {
  #  return votes / (1 + ln(x/2 + 1))
  # }
end
