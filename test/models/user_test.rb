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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "Fixture user boris is valid" do
    user = users(:boris)
    assert user.valid?
  end

  test "User is invalid without a github nickname" do
    user = User.new(github_nickname: nil)
    refute user.valid?, user.errors.full_messages
  end
end
