class QuestionsController < ApplicationController
  before_action :require_api_key
  before_action :increment_api_request_count!

  def question
    one_question = shareable_questions.where({ id: params['id'] }).first

    return head :no_content if one_question.nil?

    render_question one_question
  end

  def questions
    all_questions = shareable_questions

    return head :no_content unless all_questions.count > 0

    render_question all_questions
  end

  private
  def shareable_questions
    Question.where :share => true
  end

  def require_api_key
    tenant = Tenant.where(id: params['tenant_id'].to_i).first
    return forbidden_status unless tenant && params['api_key'] == tenant.api_key
  end

  def forbidden_status
    return render json: {}, status: :forbidden
  end

  def increment_api_request_count!
    tenant = Tenant.where(id: params['tenant_id'].to_i).first
    tenant.api_request_count = tenant.api_request_count + 1
    tenant.save!
  end

  def render_question question_entity
    render json: question_entity.to_json(include: [:user, :answers])
  end
end
