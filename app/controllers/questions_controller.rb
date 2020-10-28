class QuestionsController < ApplicationController
  def api_key_missing?
    tenant = Tenant.where(id: params['tenant_id'].to_i).first
    return true unless tenant && params['api_key'] == tenant.api_key
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

  def question
    return forbidden_status if api_key_missing?
    increment_api_request_count!

    question = Question.where({ share: true, id: params['id'] }).first
    return head :no_content if question.nil?

    render_question question
  end

  def questions
    return forbidden_status if api_key_missing?
    increment_api_request_count!
    questions = Question.where :share => true

    return head :no_content unless questions.count > 0

    render_question questions
  end
end
