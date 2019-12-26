require 'test_helper'

class CommonPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get common_pages_home_url
    assert_response :success
  end

  test "should get help" do
    get common_pages_help_url
    assert_response :success
  end

end
