require 'test_helper'

class ApplicationControllerTest < ActionController::TestCase
  test "should return no content if there are no questions" do
    get :questions
    assert_response 204
  end
end
