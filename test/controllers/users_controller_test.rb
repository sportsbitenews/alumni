class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "can see user profile when not connected" do
    boris = users(:boris)

    get :show, { 'github_nickname' => boris.github_nickname }
    assert_response :success

    assert_select "#user-email", 0
  end

  test "can see user profile when connected" do
    boris = users(:boris)
    sign_in boris

    get :show, { 'github_nickname' => boris.github_nickname }
    assert_response :success

    assert_select "h1", boris.name
  end
end
