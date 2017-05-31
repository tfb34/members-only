require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@user = User.new(name: "Namjoon",
  					email: "random@example.com",
  					password: "foobar",
  					password_confirmation: "foobar")
  end

  test "user should be valid" do
  	assert @user.valid?
  end
  
  test "should have a name" do
  	@user.name = "      "
  	assert_not @user.valid?
  end
  
  test "name should not be too long" do
  	@user.name = 'a'*36
  	assert_not @user.valid?
  end

  test "should have an email" do
  	@user.email = "       "
  	assert_not  @user.valid?
  end

  test "email should not be too long" do
  	@user.email = 'a'*244 + "@example.com"
  	assert_not @user.valid?
  end

  test "email should be unique" do
  	duplicate_user = User.new(name:"Charles")
    duplicate_user.email = @user.email.upcase #not case-sensitive
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "password should be present(nonblank)" do
  	@user.password = " "*10
  	assert_not @user.valid?
  end

  test "password should have minimum length" do
  	@user.password = 'a'*5
  	assert_not @user.valid?
  end

end
