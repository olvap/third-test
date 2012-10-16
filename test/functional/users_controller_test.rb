require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get checkLogin" do
    get :checkLogin
    assert_response :success
  end

  test "should get addUser" do
    get :addUser
    assert_response :success
  end

end
