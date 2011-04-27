require 'test_helper'

class SurveyControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get start" do
    get :start
    assert_response :success
  end

  test "should get page" do
    get :page
    assert_response :success
  end

  test "should get feedback" do
    get :feedback
    assert_response :success
  end

end
