class ScreenedUser < ActiveRecord::Base
  validates :github_nickname, uniqueness: { allow_nil: false }
end
