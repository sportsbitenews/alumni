# == Schema Information
#
# Table name: batches
#
#  id                      :integer          not null, primary key
#  slug                    :string
#  city_id                 :integer
#  starts_at               :date
#  ends_at                 :date
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  onboarding              :boolean          default(FALSE), not null
#  slack_id                :string
#  youtube_id              :string
#  live                    :boolean          default(FALSE), not null
#  meta_image_file_name    :string
#  meta_image_content_type :string
#  meta_image_file_size    :integer
#  meta_image_updated_at   :datetime
#  last_seats              :boolean          default(FALSE), not null
#  full                    :boolean          default(FALSE), not null
#  time_zone               :string           default("Paris")
#
# Indexes
#
#  index_batches_on_city_id  (city_id)
#

class Batch < ActiveRecord::Base
  validates :slug, presence: true, uniqueness: true
  validates :city, presence: true
  validates :starts_at, presence: true
  validates :time_zone, presence: true

  belongs_to :city
  has_many :users  # Students
  has_many :projects, -> { order(position: :asc) }
  has_many :featured_projects, -> { where(featured: true) }, class_name: "Project"
  has_and_belongs_to_many :teachers, class_name: "User", foreign_key: "batch_id"

  before_validation :set_ends_at
  after_create :create_slack_channel
  after_create :push_to_kitt

  has_attached_file :meta_image,
    styles: { facebook: { geometry: "1410x738>", format: 'jpg' } }
  validates_attachment_content_type :meta_image,
    content_type: /\Aimage\/.*\z/

  def set_ends_at
    self.ends_at = self.starts_at + 9.weeks - 3.days if self.starts_at
  end

  def create_slack_channel
    CreateSlackChannelJob.perform_later(id) if slack_id.blank?
  end

  def push_to_kitt
    CreateCampInKitt.perform_later(id)
  end

  def name
    "Batch #{slug} - #{city.try(:name)}"
  end
end
