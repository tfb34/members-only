require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  #test "should get show" do
   # get user_path
    #assert_response :success
  #end

end
