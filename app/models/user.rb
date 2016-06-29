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
#  picture_file_name      :string
#  picture_content_type   :string
#  picture_file_size      :integer
#  picture_updated_at     :datetime
#  role                   :string
#  twitter_nickname       :string
#  noindex                :boolean          default(FALSE), not null
#  private_bio            :text
#  status                 :string
#  mood                   :text
#  linkedin_nickname      :string
#  facebook_nickname      :string
#  pre_wagon_experiences  :jsonb            is an Array
#  post_wagon_experiences :jsonb            is an Array
#
# Indexes
#
#  index_users_on_batch_id              (batch_id)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  include Cacheable
  PUBLIC_PROPERTIES = %i(id github_nickname first_name last_name thumbnail)
  PRIVATE_PROPERTIES = %i(email slack_uid connected_to_slack)

  devise :trackable, :database_authenticatable
  devise :omniauthable, :omniauth_providers => [:github, :slack]

  validates :github_nickname, uniqueness: { allow_nil: false, case_sensitive: false }
  validates :email, uniqueness: { allow_blank: false, case_sensitive: false }

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

  has_attached_file :picture,
    styles: { medium: "300x300>", thumb: "100x100>" },
    processors: [ :thumbnail, :paperclip_optimizer ]

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

  acts_as_voter

  # after_save ->() { Mailchimp.new.subscribe_to_alumni_list(self) if self.alumni }

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

  def thumbnail(style = :medium)
    picture.exists? ? picture.url(style) : gravatar_url
  rescue SocketError
    gravatar_url
  end

  def ready_for_validation?
    !alumni && first_name.present? && last_name.present?
  end

  def self.find_by_slug(slug)
    find_by_github_nickname slug
  end

  private

  def octokit_client
    @octokit_client ||= Octokit::Client.new(access_token: github_token)
  end
end
