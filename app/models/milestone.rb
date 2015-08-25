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

class Milestone < ActiveRecord::Base
  include Post
  belongs_to :project

  validates :project_id, presence: true
  validates :content, presence: true
end
