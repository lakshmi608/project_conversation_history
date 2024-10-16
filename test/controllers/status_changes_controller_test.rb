require "test_helper"

class StatusChangesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get status_changes_create_url
    assert_response :success
  end
end
