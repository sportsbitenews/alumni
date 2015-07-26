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
  belongs_to :user
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true
  validates :user, presence: true
  acts_as_votable

  has_many :answers, as: :answerable
end
