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

class Resource < ActiveRecord::Base
  include Post
  validates :tagline, presence: true
  validates :url, presence: true, url: true, uniqueness: true
end
