require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

def setup
  @user = users(:derek)
  remember(@user)
end

  test "current_user returns right user wehn session is nil" do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test "currnet_user returns nil when remember digest is wrong" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nill current_user
  end
end
