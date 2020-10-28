class AddApiRequestCountToTenant < ActiveRecord::Migration[5.2]
  def change
    add_column :tenants, :api_request_count, :number, default: 0
  end
end
