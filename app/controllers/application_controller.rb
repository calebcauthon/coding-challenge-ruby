class ApplicationController < ActionController::Base
  def questions
    tenant = Tenant.where(id: params['tenant_id'].to_i).first
    return render json: {}, status: :forbidden unless tenant && params['api_key'] == tenant.api_key

    questions = Question.includes(:user, :answers).where :share => true

    tenant = Tenant.where(id: params['tenant_id'].to_i).first
    if tenant
      tenant.api_request_count = tenant.api_request_count + 1
      tenant.save!
    end

    return head :no_content unless questions.count > 0

    render json: questions.to_json(include: [:user, :answers])
  end
end
