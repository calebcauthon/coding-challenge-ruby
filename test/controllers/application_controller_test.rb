require 'test_helper'
require 'json'

class ApplicationControllerTest < ActionController::TestCase
  test "should return no content if there are no questions" do
    get :questions
    assert_response 204
  end

  test "should return questions that are shareable" do
    Question.create!(share: true, title: 'question', user: User.new)
    get :questions
    assert_equal 1, JSON.parse(response.body).count
  end

  test "should *only* return questions that are shareable" do
    Question.create!(share: false, title: 'question', user: User.new)
    get :questions
    assert_response 204
  end
end
