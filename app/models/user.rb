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
#  provider               :string
#  uid                    :string
#  github_nickname        :string
#  gravatar_url           :string
#  name                   :string
#  github_token           :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  LEWAGON_GITHUB_ORGANIZATION = 'lewagon'.freeze

  devise :trackable, :database_authenticatable
  devise :omniauthable, :omniauth_providers => [:github]

  validates :github_nickname, uniqueness: { allow_nil: false }
  validate :belongs_to_lewagon_github_org

  has_many :resources

  def self.find_for_github_oauth(auth)
    user = where(provider: 'github', uid: auth[:uid]).first || User.new
    store_github_info(user, auth)
    user
  end

  def self.store_github_info(user, auth)
    user.provider = 'github'
    user.uid = auth.uid
    user.email = auth.info.email
    user.github_token = auth.credentials.token
    user.gravatar_url = auth.info.image
    user.github_nickname = auth.info.nickname
  end

  private

  def octokit_client
    @octokit_client ||= Octokit::Client.new(access_token: github_token)
  end

  def belongs_to_lewagon_github_org
    unless octokit_client.organization_member?(LEWAGON_GITHUB_ORGANIZATION, github_nickname)
      errors.add(:github_nickname, "Sorry, you don't belong to lewagon GitHub organization")
    end
  end
end
