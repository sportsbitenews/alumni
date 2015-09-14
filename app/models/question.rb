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
#
# Indexes
#
#  index_questions_on_user_id  (user_id)
#

class Question < ActiveRecord::Base
  include Post
  COLOR_FROM = '#f46b45'
  COLOR_TO = '#eea849'

  validates :content, presence: true

  def search_data
    super as_json(only: [:title, :content])
  end

  def slack_fallback
    "New question from #{user.name}: #{title}"
  end

  def slack_pretext
    "Someone needs us. Let's gather and help him/her!"
  end

  def slack_title
    title
  end

  def slack_text
    content
  end
end
