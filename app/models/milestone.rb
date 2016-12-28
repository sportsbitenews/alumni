# == Schema Information
#
# Table name: milestones
#
#  id         :integer          not null, primary key
#  project_id :integer
#  title      :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_milestones_on_project_id  (project_id)
#  index_milestones_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_56886b3a4d  (user_id => users.id)
#  fk_rails_9bd0a0c791  (project_id => projects.id)
#

class Milestone < ActiveRecord::Base
  include Post
  COLOR_FROM = '#232526'
  COLOR_TO = '#414345'

  belongs_to :project

  validates :project_id, presence: true
  validates :content, presence: true

  def search_data
    super as_json(only: [:title, :content])
  end

  def slack_fallback
    "New milestone for #{project.name} : #{title}"
  end

  def slack_pretext
    "New milestone for *#{project.name}*!"
  end

  def slack_title
    title
  end

  def slack_text
    content
  end
end
