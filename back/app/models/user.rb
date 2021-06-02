class User < ApplicationRecord
  has_secure_password
  has_many :items

  validates :email, presence: true
end