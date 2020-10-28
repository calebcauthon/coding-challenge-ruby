ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  self.use_transactional_tests = true

  def get_authorized *params
    tenant = Tenant.create! name: 'tenant-authorized-1'

    params[1] = { params: {} } if params[1].nil?
    params[1][:params][:api_key] = tenant.api_key
    params[1][:params][:tenant_id] = tenant.id

    get *params
  end
end
