# == Schema Information
#
# Table name: cities
#
#  id                               :integer          not null, primary key
#  name                             :string
#  created_at                       :datetime         not null
#  updated_at                       :datetime         not null
#  location                         :string
#  address                          :string
#  description_fr                   :text
#  description_en                   :text
#  meetup_id                        :integer
#  twitter_url                      :string
#  latitude                         :float
#  longitude                        :float
#  slug                             :string
#  course_locale                    :string
#  logistic_specifics               :text
#  company_name                     :string
#  company_nature                   :string
#  company_hq                       :string
#  company_purpose_and_registration :string
#  training_address                 :string
#  apply_facebook_pixel             :string
#  mailchimp_list_id                :string
#  mailchimp_api_key                :string
#  slack_channel_id                 :string
#  marketing_specifics              :text
#  contact_phone_number             :string
#  contact_phone_number_displayed   :boolean          default(FALSE), not null
#  contact_phone_number_name        :string
#  city_group_id                    :integer
#  slack_channel_name               :string
#  email                            :string
#
# Indexes
#
#  index_cities_on_city_group_id  (city_group_id)
#  index_cities_on_slug           (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_a3b5ea2ee7  (city_group_id => city_groups.id)
#

class City < ActiveRecord::Base
  include Cacheable
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :slug, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
  validates :course_locale, presence: true, inclusion: { in: %w(en fr pt-BR zh-CN) }

  before_validation :check_mailchimp_account, if: 'mailchimp_api_key_changed? || mailchimp_list_id_changed?'

  has_attachment :city_background_picture
  has_attachment :location_background_picture
  has_attachment :classroom_background_picture

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  has_many :batches
  belongs_to :city_group


  def open_batches
    batches.where(open_for_registration: true).order(:starts_at)
  end

  def encrypted_mailchimp_api_key
    return nil if mailchimp_api_key.blank?
    salt  = SecureRandom.base64
    key   = ActiveSupport::KeyGenerator.new(ENV['ALUMNI_WWW_ENCRYPING_KEY']).generate_key(salt)
    crypt = ActiveSupport::MessageEncryptor.new(key[0..31])
    salt + "@" + crypt.encrypt_and_sign(mailchimp_api_key)
  end

  %i(teachers users projects).each do |method|
    define_method method do
      batches.includes(method).order(starts_at: :desc).map(&method).flatten.uniq
    end
  end

  private

  def check_mailchimp_account
    return if mailchimp_api_key.blank?
    return if mailchimp_list_id.blank?
    begin
      gibbon = Gibbon::Request.new(api_key: mailchimp_api_key)
      gibbon.lists(mailchimp_list_id).retrieve
    rescue Gibbon::MailChimpError => e
      if e.title =~ /Key/
        errors.add :mailchimp_api_key, e.title
      elsif e.title == "Resource Not Found"
        errors.add :mailchimp_list_id, "can't be found"
      else
        errors.add :mailchimp_api_key, e.message
      end
    end
  end
end
