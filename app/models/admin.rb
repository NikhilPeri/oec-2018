class Admin < ApplicationRecord
  has_secure_password

  validate :admin_not_configured?

  def admin_not_configured?
    return Admin.count == 0
  end
end
