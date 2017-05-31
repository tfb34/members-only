require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "login with invalid information" do
  	get login_path
  	assert_response :success
  	post login_path, params: { session: {email: "invalid_email@example.com",
  							  password: "password"}}
    
    assert_select "h3", "error : Invalid email/password combination"
  end

  #test "login with valid information" do 
  #	get login_path
  #	assert_response :success
  #	post login_path, params: {session: {email: "example_1@example.com",
  #										password: "password"}}

  #	assert_select "h3", "success"
  #end
end
