class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :invitees
  has_many :parties

  validates :email, uniqueness: true, presence: true

  has_secure_password
end
