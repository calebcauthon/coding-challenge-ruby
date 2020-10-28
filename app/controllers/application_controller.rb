class ApplicationController < ActionController::Base
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

  def question
    return forbidden_status if api_key_missing?

    question = Question.where({ share: true }).first
    return head :no_content if question.nil?

    increment_api_request_count!

    return render json: question.to_json(include: [:user, :answers])
  end

  def questions
    return forbidden_status if api_key_missing?

    questions = Question.where :share => true

    increment_api_request_count!

    return head :no_content unless questions.count > 0

    render json: questions.to_json(include: [:user, :answers])
  end
end
