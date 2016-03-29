require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "Fixture user boris is valid" do
    user = users(:boris)
    assert user.valid?
  end

  test "User is invalid without a github nickname" do
    user = User.new(github_nickname: nil)
    refute user.valid?
  end
end
