class Tenant < ApplicationRecord

  before_create :generate_api_key
  validates_presence_of :name

  private

  def generate_api_key
    self.api_key = SecureRandom.hex(16)
  end
end
