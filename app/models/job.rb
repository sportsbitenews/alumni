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
# Foreign Keys
#
#  fk_rails_df6238c8a6  (user_id => users.id)
#

class Job < ActiveRecord::Base
  include Post
  COLOR_FROM = '#4776E6'
  COLOR_TO = '#8E54E9'

  validates :company, presence: true
  validates :description, presence: true
  validates :city, presence: true, if: :remote_false?

  def remote_false?
    !remote
  end

  def search_data
    super as_json(only: [:title, :company, :description])
  end

  def slack_fallback
    "New job: #{slack_title}"
  end

  def slack_pretext
    "A new job has been posted."
  end

  def slack_title
    "#{title} (#{contract}) @ #{company} #{city.blank? ? 'Remote' : "in #{city}"}"
  end

  def slack_text
    description
  end
end
