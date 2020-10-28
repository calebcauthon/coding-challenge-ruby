class ApplicationController < ActionController::Base
  def question
    tenant = Tenant.where(id: params['tenant_id'].to_i).first
    return render json: {}, status: :forbidden unless tenant && params['api_key'] == tenant.api_key

    question = Question.where({ share: true }).first
    return head :no_content if question.nil?

    tenant = Tenant.where(id: params['tenant_id'].to_i).first
    if tenant
      tenant.api_request_count = tenant.api_request_count + 1
      tenant.save!
    end

    return render json: question.to_json(include: [:user, :answers])
  end

  def questions
    tenant = Tenant.where(id: params['tenant_id'].to_i).first
    return render json: {}, status: :forbidden unless tenant && params['api_key'] == tenant.api_key

    questions = Question.where :share => true

    tenant = Tenant.where(id: params['tenant_id'].to_i).first
    if tenant
      tenant.api_request_count = tenant.api_request_count + 1
      tenant.save!
    end

    return head :no_content unless questions.count > 0

    render json: questions.to_json(include: [:user, :answers])
  end
end
