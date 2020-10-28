class WelcomeController < ApplicationController
  def index
  end

  def dashboard
    user_count = User.all.count
    question_count = Question.all.count
    answer_count = Answer.all.count
    render :dashboard, :locals => { :user_count => user_count, :question_count => question_count, :answer_count => answer_count }
  end
end
