class Admin < ApplicationRecord
  has_secure_password
  belongs_to :exchange
end
