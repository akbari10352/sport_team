class User < ApplicationRecord

  has_secure_password
  has_one :team
  validates :email, presence: true, uniqueness: true

end
