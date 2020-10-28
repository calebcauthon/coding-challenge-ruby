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

  test "default api request count is zero" do
    tenant = Tenant.create! name: 'tenant-1'
    assert_equal 0, tenant.api_request_count
  end

  test "should increment the api request count for the tenant when getting questions" do
    tenant1 = Tenant.create! name: 'tenant-1'
    tenant2 = Tenant.create! name: 'tenant-2'
    tenant3 = Tenant.create! name: 'tenant-3'
    get :questions, { params: { tenant_id: tenant2.id } }

    tenant1 = Tenant.where(name: 'tenant-1').first
    tenant2 = Tenant.where(name: 'tenant-2').first
    tenant3 = Tenant.where(name: 'tenant-3').first

    assert_equal 0, tenant1.api_request_count
    assert_equal 1, tenant2.api_request_count
    assert_equal 0, tenant3.api_request_count
  end
end
