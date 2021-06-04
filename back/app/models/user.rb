class User < ApplicationRecord
  has_secure_password
  has_many :items
  has_one :setting

  validates_uniqueness_of :username
  validates_presence_of :username

  after_create :create_setting

  private

    def create_setting
      Setting.create(user: self)
    end
  
end
