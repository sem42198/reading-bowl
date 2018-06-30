require 'test_helper'

class Concerns::WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get concerns_welcome_index_url
    assert_response :success
  end

end
