class ApplicationController < ActionController::Base
  def questions
    questions = Question.where :share => true

    return head :no_content unless questions.count > 0

    render json: questions.to_json
  end
end
