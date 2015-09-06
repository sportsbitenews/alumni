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
#
# Indexes
#
#  index_users_on_batch_id              (batch_id)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  PUBLIC_PROPERTIES = %i(id github_nickname gravatar_url first_name last_name)
  PRIVATE_PROPERTIES = %i(slack_uid connected_to_slack)

  devise :trackable, :database_authenticatable
  devise :omniauthable, :omniauth_providers => [:github, :slack]

  validates :github_nickname, uniqueness: { allow_nil: false }

  belongs_to :batch
  has_many :resources
  has_many :jobs
  has_many :questions
  has_many :milestones
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :cities

  acts_as_voter

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

  def user_messages_slack_url
    @user_messages_slack_url ||= SlackService.new.user_messages_slack_url(self)
  end

  def legit?
    admin || staff || teacher || teacher_assistant || alumni
  end

  def name
    "#{first_name} #{last_name}"
  end

  private

  def octokit_client
    @octokit_client ||= Octokit::Client.new(access_token: github_token)
  end
end
