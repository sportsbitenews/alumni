# == Schema Information
#
# Table name: answers
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  content         :text
#  answerable_id   :integer
#  answerable_type :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_answers_on_user_id  (user_id)
#

class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :answerable, polymorphic: true
  validates :content, presence: true
  validates :user, presence: true
  validates :answerable_id, presence: true
  validates :answerable_type, presence: true
end
