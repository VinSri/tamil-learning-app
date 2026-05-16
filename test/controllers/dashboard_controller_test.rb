require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "redirects to sign in when not authenticated" do
    get dashboard_path
    assert_redirected_to new_user_session_path
  end

  test "returns 200 for authenticated user" do
    sign_in users(:vino)
    get dashboard_path
    assert_response :success
  end
end
