# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  title      :string
#  content    :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  solved     :boolean          default(FALSE), not null
#
# Indexes
#
#  index_questions_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_047ab75908  (user_id => users.id)
#

class Question < ActiveRecord::Base
  include Post
  COLOR_FROM = '#f46b45'
  COLOR_TO = '#eea849'

  validates :content, presence: true

  def search_data
    super as_json(only: [:title, :content])
  end
end
