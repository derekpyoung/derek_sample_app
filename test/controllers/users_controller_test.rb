require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  before_action :logged_in_user, only: [:edit, :update]

  def setup
    @user = users(:derek)
    @other_user = users(:bob)
  end

  def "should redirect index when not logged in" do
    get :index
    assert_redirect_to login_url
  end 

  test "should get new" do
    get users_new_url
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirect_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: {name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirect_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirect_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: {name: @user.name,
                                              email: @user.email } }
    assert flash.empty?
    assert_redirect_to root_url
  end
end
