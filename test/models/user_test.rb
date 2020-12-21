require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name:"Example User", email:"user@example.com",
                      password: "foobar", password_confirmation: "foobar")

  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "Name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "Email should not be too long" do
    @user.name = "a" * 256
    assert_not @user.valid?
  end

  test "Email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                        first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_addresses|
      @user.email = valid_addresses
      assert @user.valid? " #{valid_addresses.inspect} Should be Valid"
  end

  test "email validation should reject invalid emails" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example
                          foo@bar_baz.com fooo@bar+baz.com]
    invalid_addresses.each do |invalid_addresses|
      @user.email = invalid_addresses
      assert_not @user.valid? "#{valid_addresses.inspect} Should be invalid"
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "Password should have a minimum length" do
    @user.passord = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated should return false for a user with nil digest" do
    assert_not @user.authenticated('')
  end

end
