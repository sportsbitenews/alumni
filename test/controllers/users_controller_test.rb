class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "can see own profile when not connected" do
    boris = users(:boris)

    get :show, { 'github_nickname' => boris.github_nickname }
    assert_response :success

    assert_select "#user-email", 0
    assert_select "#user-slack", 0
  end

  test "can see own profile when connected and staff" do
    boris = users(:boris)
    sign_in boris

    get :show, { 'github_nickname' => boris.github_nickname }
    assert_response :success

    assert_select "h1", boris.name
    assert_select "#user-email", 1
  end

  test "can see own profile when connected and TA or teacher" do
    nico = users(:nico)
    sign_in nico

    get :show, { 'github_nickname' => nico.github_nickname }
    assert_response :success

    assert_select "h1", nico.name
    assert_select "#user-email", 1
  end

  test "can see own profile when connected and alumni" do
    arthur = users(:arthur)
    sign_in arthur

    get :show, { 'github_nickname' => arthur.github_nickname }
    assert_response :success

    assert_select "h1", arthur.name
    assert_select "#user-email", 1
  end

  test "can see alumni contact when connected" do
    nico = users(:nico)
    arthur = users(:arthur)
    sign_in nico
    get :show, { 'github_nickname' => arthur.github_nickname }
    assert_response :success

    assert_select "#user-email", 1
  end
end
