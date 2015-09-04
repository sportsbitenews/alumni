# == Schema Information
#
# Table name: projects
#
#  id                         :integer          not null, primary key
#  name                       :string
#  url                        :string
#  batch_id                   :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  tagline                    :string
#  cover_picture_file_name    :string
#  cover_picture_content_type :string
#  cover_picture_file_size    :integer
#  cover_picture_updated_at   :datetime
#
# Indexes
#
#  index_projects_on_batch_id  (batch_id)
#

class Project < ActiveRecord::Base
  belongs_to :batch
  has_many :milestones
  has_and_belongs_to_many :users
  acts_as_votable

  validates :name, presence: true
  validates :url, presence: true
end
