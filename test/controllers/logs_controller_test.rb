require 'test_helper'

class LogsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get logs_update_url
    assert_response :success
  end

end
