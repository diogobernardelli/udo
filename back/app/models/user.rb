class User < ApplicationRecord
  has_secure_password
  has_many :items
  has_one :setting

  validates_uniqueness_of :username
  validates_presence_of :username
end
