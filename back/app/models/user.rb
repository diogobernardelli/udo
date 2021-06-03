class User < ApplicationRecord
  has_secure_password
  has_many :items

  validates_uniqueness_of :username
  validates_presence_of :username
end
