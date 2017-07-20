# == Schema Information
#
# Table name: resources
#
#  id             :integer          not null, primary key
#  title          :string
#  url            :string
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  tagline        :string
#  screenshot_url :string
#
# Indexes
#
#  index_resources_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_250ed64e61  (user_id => users.id)
#

class Resource < ActiveRecord::Base
  include Post
  COLOR_FROM = '#ffb347'
  COLOR_TO = '#ffcc33'

  validates :tagline, presence: true
  before_validation :normalize_url
  validates :url, presence: true, url: true, uniqueness: true

  def search_data
    super as_json(only: [:title, :tagline, :url])
  end

  private

  def normalize_url
    uri = URI.parse url.strip
    self.url = uri.normalize
  end
end
