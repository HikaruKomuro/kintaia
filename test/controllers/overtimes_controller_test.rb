require 'test_helper'

class OvertimesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get overtimes_create_url
    assert_response :success
  end

end
