require "test_helper"

class DeputyControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get deputy_index_url
    assert_response :success
  end
end
