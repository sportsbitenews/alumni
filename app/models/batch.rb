# == Schema Information
#
# Table name: batches
#
#  id                       :integer          not null, primary key
#  slug                     :string
#  city_id                  :integer
#  starts_at                :date
#  ends_at                  :date
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  onboarding               :boolean          default(FALSE), not null
#  slack_id                 :string
#  youtube_id               :string
#  live                     :boolean          default(FALSE), not null
#  meta_image_file_name     :string
#  meta_image_content_type  :string
#  meta_image_file_size     :integer
#  meta_image_updated_at    :datetime
#  last_seats               :boolean          default(FALSE), not null
#  full                     :boolean          default(FALSE), not null
#  time_zone                :string           default("Paris")
#  open_for_registration    :boolean          default(FALSE), not null
#  trello_inbox_list_id     :string
#  price_cents              :integer          default(0), not null
#  price_currency           :string           default("EUR"), not null
#  cover_image_file_name    :string
#  cover_image_content_type :string
#  cover_image_file_size    :integer
#  cover_image_updated_at   :datetime
#  waiting_list             :boolean          default(FALSE), not null
#
# Indexes
#
#  index_batches_on_city_id  (city_id)
#

class Batch < ActiveRecord::Base
  include Cacheable

  validates :slug, uniqueness: true, allow_nil: true, allow_blank: true
  validates :city, presence: true
  validates :starts_at, presence: true
  validates :time_zone, presence: true
  validates :price_cents, numericality: { greater_than: 3_000_00 }  # cents

  belongs_to :city
  has_many :users  # Students
  has_many :projects, -> { order(position: :asc) }
  has_and_belongs_to_many :teachers, class_name: "User", foreign_key: "batch_id"

  before_validation :set_ends_at, if: ->(batch) { batch.starts_at_changed? && !batch.ends_at_changed? }

  after_create :create_trello_board
  after_save :create_slack_channel, if: :slug_set?
  after_save :push_to_kitt, if: :slug_set?
  monetize :price_cents

  scope :completed_or_in_progress, -> { where('starts_at <= ?', Date.today) }

  # TODO(ssaunier):
  # after_create :create_trello_board

  has_attached_file :meta_image,
    styles: { facebook: { geometry: "1410x738>", format: 'jpg' } }, processors: [ :thumbnail, :paperclip_optimizer ]
  validates_attachment_content_type :meta_image,
    content_type: /\Aimage\/.*\z/
  has_attached_file :cover_image,
    styles: { large: "1500x844>" }, processors: [ :thumbnail ]
  validates_attachment_content_type :cover_image,
    content_type: /\Aimage\/.*\z/

  def set_ends_at
    self.ends_at = self.starts_at + 9.weeks - 3.days if self.starts_at
  end

  def user_count
    users.size
  end

  def slack_channel_name
    "batch-#{slug}-#{city.name.downcase.gsub(/[ -]/, "")}"
  end

  def create_trello_board
    CreateTrelloBoard.set(wait: 10.seconds).perform_later(id)
  end

  def create_slack_channel
    CreateSlackChannelJob.set(wait: 10.seconds).perform_later(id) if slack_id.blank?
  end

  def push_to_kitt
    CreateCampInKitt.set(wait: 10.seconds).perform_later(id)
  end

  def name
    "Batch #{slug} - #{city.try(:name)}"
  end

  def slug_set?
    !slug.empty? && (id_changed? || slug_changed?)
  end
end
