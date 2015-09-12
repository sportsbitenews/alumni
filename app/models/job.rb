# == Schema Information
#
# Table name: jobs
#
#  id            :integer          not null, primary key
#  company       :string
#  title         :string
#  ad_url        :string
#  contact_email :string
#  city          :string
#  remote        :boolean
#  contract      :string
#  description   :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#
# Indexes
#
#  index_jobs_on_user_id  (user_id)
#

class Job < ActiveRecord::Base
  include Post
  validates :company, presence: true
  validates :description, presence: true
  validates :city, presence: true, if: :remote_false?

  def remote_false?
    !remote
  end

  def search_data
    super as_json(only: [:title, :company, :description])
  end
end
