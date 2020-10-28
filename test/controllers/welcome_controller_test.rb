require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should include total number of users" do
    4.times do
      User.create! name: 'me'
    end

    get :dashboard

    assert_select "td#user-count", '4'
  end
end
