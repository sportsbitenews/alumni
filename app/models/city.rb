# == Schema Information
#
# Table name: cities
#
#  id                             :integer          not null, primary key
#  name                           :string
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#  location                       :string
#  address                        :string
#  description_fr                 :text
#  description_en                 :text
#  meetup_id                      :integer
#  twitter_url                    :string
#  city_picture_file_name         :string
#  city_picture_content_type      :string
#  city_picture_file_size         :integer
#  city_picture_updated_at        :datetime
#  location_picture_file_name     :string
#  location_picture_content_type  :string
#  location_picture_file_size     :integer
#  location_picture_updated_at    :datetime
#  latitude                       :float
#  longitude                      :float
#  slug                           :string
#  classroom_picture_file_name    :string
#  classroom_picture_content_type :string
#  classroom_picture_file_size    :integer
#  classroom_picture_updated_at   :datetime
#  course_locale                  :string
#  specifics                      :text
#
# Indexes
#
#  index_cities_on_slug  (slug) UNIQUE
#

class City < ActiveRecord::Base
  include Cacheable
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :slug, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :course_locale, presence: true,  inclusion: { in: %w(en fr) }
  has_attached_file :city_picture,
    styles: { cover: { geometry: "1400x787>", format: 'jpg', quality: 40 },  thumbnail: { geometry: "540x360>", format: 'jpg', quality: 70 } }
  has_attached_file :location_picture,
    styles: { cover: { geometry: "1400x787>", format: 'jpg', quality: 40 } }
  has_attached_file :classroom_picture,
    styles: { cover: { geometry: "1400x787>", format: 'jpg', quality: 40 } }
  validates_attachment_content_type :city_picture,
    content_type: /\Aimage\/.*\z/
  validates_attachment_content_type :location_picture,
    content_type: /\Aimage\/.*\z/
  validates_attachment_content_type :classroom_picture,
    content_type: /\Aimage\/.*\z/

  geocoded_by :address
  after_validation :geocode, classroom_pictureif: :address_changed?

  has_many :batches

  def open_batches
    batches.where(open_for_registration: true).order(:starts_at)
  end

  %i(teachers users projects).each do |method|
    define_method method do
      batches.includes(method).order(starts_at: :desc).map(&method).flatten.uniq
    end
  end
end
