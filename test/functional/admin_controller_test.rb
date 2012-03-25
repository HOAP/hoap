require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get participant" do
    get :participant
    assert_response :success
  end

  test "should get export" do
    get :export
    assert_response :success
  end

end
