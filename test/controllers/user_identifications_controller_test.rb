require 'test_helper'

class UserIdentificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_identifications_new_url
    assert_response :success
  end

end
