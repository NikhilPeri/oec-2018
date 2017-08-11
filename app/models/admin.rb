class Admin < ApplicationRecord
  has_secure_password

  has_one :exchange

  validate :single_admin

  def single_admin
    if Admin.count != 0
      self.errors.add(:admin, " user already configured")
      return false
    end
  end
end
