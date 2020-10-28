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

  test "should include total number of questions" do
    5.times do
      Question.create! title: 'question-title', user: User.new
    end

    get :dashboard

    assert_select "td#question-count", '5'
  end

  test "should include total number of answers" do
    6.times do
      Answer.create! body: 'body', question: Question.new(title: 'title'), user: User.new
    end

    get :dashboard

    assert_select "td#answer-count", '6'
  end

  test "should include api request count for each tenant" do
    tenant1 = Tenant.create!(name: 'Tenant One', api_request_count: 30)
    tenant2 = Tenant.create!(name: 'Tenant Two', api_request_count: 40)
    get :dashboard
    assert_select "td.tenant-name", "Tenant One"
    assert_select "td.tenant-request-count[data-tenant-id=#{tenant1.id}]", "30"
    assert_select "td.tenant-name", "Tenant Two"
    assert_select "td.tenant-request-count[data-tenant-id=#{tenant2.id}]", "40"
  end
end
