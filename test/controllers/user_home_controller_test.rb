require 'test_helper'

class UserHomeControllerTest < ActionDispatch::IntegrationTest
  test "should get instructor_home" do
    get user_home_instructor_home_url
    assert_response :success
  end

  test "should get student_home" do
    get user_home_student_home_url
    assert_response :success
  end

end
