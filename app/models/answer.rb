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
# Foreign Keys
#
#  fk_rails_584be190c2  (user_id => users.id)
#

class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :answerable, polymorphic: true
  validates :content, presence: true
  validates :user, presence: true
  validates :answerable_id, presence: true
  validates :answerable_type, presence: true

  def slack_content_preview
    content.scan(/\B@\S*/).flatten.each do |mention|
      content.gsub!(mention, "*#{mention}*")
    end
    content.length > 60 ? (content[0..60] + "... " + "<" + Rails.application.routes.url_helpers.send(:"#{answerable.class.to_s.downcase}_url", answerable, anchor: "answer-#{id}") + "|check out full answer>") : content + " <" + Rails.application.routes.url_helpers.send(:"#{answerable.class.to_s.downcase}_url", answerable, anchor: "answer-#{id}") + "| Answer here!>"
  end
end
