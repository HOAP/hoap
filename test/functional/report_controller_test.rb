require 'test_helper'

class ReportControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get facts" do
    get :facts
    assert_response :success
  end

  test "should get support" do
    get :support
    assert_response :success
  end

  test "should get tips" do
    get :tips
    assert_response :success
  end

end
