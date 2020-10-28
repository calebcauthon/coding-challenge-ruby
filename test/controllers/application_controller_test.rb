require 'test_helper'
require 'json'

class ApplicationControllerTest < ActionController::TestCase
  test "should return no content if there are no questions" do
    get :questions
    assert_response 204
  end

  test "should return questions that are shareable" do
    Question.create!(share: true, title: 'question-1', user: User.new)
    get :questions
    assert_equal 1, JSON.parse(response.body).count
  end

  test "should *only* return questions that are shareable" do
    Question.create!(share: false, title: 'question-2', user: User.new)
    get :questions
    assert_response 204
  end

  test "should return the user that asked the question" do
    user = User.create!(name: 'asker')
    Question.create!(share: true, title: 'question-3', user_id: user.id)

    get :questions
    assert_equal 'asker', JSON.parse(response.body).first['user']['name']
  end

  test "should return the answers to the question" do
    question = Question.create!(share: true, title: 'question-4', user: User.new)
    Answer.create!(body: 'answer-1', question: question, user: User.new)
    Answer.create!(body: 'answer-2', question: question, user: User.new)

    get :questions
    assert_equal 'answer-1', JSON.parse(response.body).first['answers'][0]['body']
    assert_equal 'answer-2', JSON.parse(response.body).first['answers'][1]['body']
  end
end
