# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  uid                    :string
#  github_nickname        :string
#  gravatar_url           :string
#  github_token           :string
#  first_name             :string
#  last_name              :string
#  alumni                 :boolean          default(FALSE), not null
#  admin                  :boolean          default(FALSE), not null
#  teacher_assistant      :boolean          default(FALSE), not null
#  teacher                :boolean          default(FALSE), not null
#  batch_id               :integer
#  slack_uid              :string
#  phone                  :string
#  slack_token            :string
#  birth_day              :date
#  school                 :string
#  staff                  :boolean          default(FALSE), not null
#  bio_en                 :text
#  bio_fr                 :text
#  role                   :string
#  twitter_nickname       :string
#  noindex                :boolean          default(FALSE), not null
#  private_bio            :text
#
# Indexes
#
#  index_users_on_batch_id              (batch_id)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_a2de7dfb00  (batch_id => batches.id)
#

class User < ActiveRecord::Base
  include Cacheable
  include CloudinaryHelper
  PUBLIC_PROPERTIES = %i(id github_nickname first_name last_name photo_path)
  PRIVATE_PROPERTIES = %i(email slack_uid connected_to_slack)

  devise :trackable, :database_authenticatable
  devise :omniauthable, :omniauth_providers => [:github, :slack]

  validates :github_nickname, presence: true, uniqueness: { allow_nil: false, case_sensitive: false }
  # validates :email, presence: true, uniqueness: true

  attr_accessor :onboarding
  validates :first_name, presence: true, if: ->(u) { u.onboarding }
  validates :last_name, presence: true, if: ->(u) { u.onboarding }
  validates :birth_day, presence: true, if: ->(u) { u.onboarding }
  validates :phone, presence: true, if: ->(u) { u.onboarding }
  validates :school, presence: true, if: ->(u) { u.onboarding }
  validates :private_bio, length: {minimum: 140}, if: ->(u) { u.onboarding }

  belongs_to :batch
  has_many :resources
  has_many :jobs
  has_many :questions
  has_many :testimonials
  has_many :answers
  has_many :milestones
  has_one  :story
  has_many :positions
  has_many :companies, through: :positions
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :cities
  has_and_belongs_to_many :batches

  acts_as_voter

  has_attachment :photo
  after_create :set_default_photo

  before_destroy :clear_from_ordered_lists

  # include Devise::Controllers::Helpers
  def self.properties(user_signed_in)
    PUBLIC_PROPERTIES + (user_signed_in ? PRIVATE_PROPERTIES : [])
  end

  def self.find_for_github_oauth(auth)
    user = where(uid: auth[:uid]).first || where(github_nickname: auth.info.nickname).first || User.new
    store_github_info(user, auth)
    user
  end

  def self.store_github_info(user, auth)
    user.uid = auth.uid
    user.email = auth.info.email
    user.github_token = auth.credentials.token
    user.gravatar_url = auth.info.image
    user.github_nickname = auth.info.nickname
  end

  def self.random
    User.find(rand(1..count))
  end

  def connected_to_slack
    @connected_to_slack ||= SlackService.new.connected_to_slack(self)
  end

  def sidebar_order
    "#{connected_to_slack ? "_" : ""}#{first_name&.downcase}"
  end

  def user_messages_slack_url
    @user_messages_slack_url ||= SlackService.new.user_messages_slack_url(self)
  end

  def legit?
    admin || staff || teacher || teacher_assistant || alumni
  end

  def name
    @name ||= (
      (first_name || "").split("-").map(&:capitalize).join("-") + " " +
      (last_name || "").split(" ").map(&:capitalize).join(" ")
    )
  end

  def thumbnail(options = {})
    self.photo.nil? ? gravatar_url : cloudinary_url(self.photo.path, options)
  rescue SocketError
    gravatar_url
  end

  def photo_path
    photo.nil? ? nil : photo.path
  end

  def ready_for_validation?
    !alumni && first_name.present? && last_name.present?
  end

  def self.find_by_slug(slug)
    find_by_github_nickname slug
  end

  def clear_from_ordered_lists
    OrderedList.where(element_type: 'User').each do |ol|
      if ol.slugs.include?(github_nickname)
        ol.slugs.delete(github_nickname)
        ol.save
      end
    end
  end

  def fetch_github_info
    client = Octokit::Client.new(access_token: User.find_by(github_nickname: 'ssaunier').github_token)
    github_user = client.user(self.github_nickname)
    self.github_nickname = github_user.login
    self.uid = github_user.id if uid.blank?
    self.gravatar_url = github_user.avatar_url if gravatar_url.blank?
    self.email = github_user.email if email.blank?
    name_parts = github_user.name.split(" ")
    self.first_name = name_parts.shift
    self.last_name = name_parts.join(" ")
  end

  private

  def octokit_client
    @octokit_client ||= Octokit::Client.new(access_token: github_token)
  end

  def set_default_photo
    if photo.nil? && !gravatar_url.blank?
      self.photo_url = gravatar_url
    end
  end
end
