class WelcomeController < ApplicationController
  def index
  end

  def dashboard
    user_count = User.all.count
    question_count = Question.all.count
    answer_count = Answer.all.count
    tenants = Tenant.all
    render :dashboard, :locals => { :tenants => tenants, :user_count => user_count, :question_count => question_count, :answer_count => answer_count }
  end
end
