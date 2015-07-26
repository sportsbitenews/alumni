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
  include Post
  validates :content, presence: true
  validates :url, presence: true, url: true, uniqueness: true
end
