require "test_helper"

class WeightLogsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get weight_logs_create_url
    assert_response :success
  end
end
