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
  validates :content, presence: true

  def search_data
    super as_json(only: [:title, :content])
  end
end
