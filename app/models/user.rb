class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :invitees
  has_secure_password
  validates :email, uniqueness: true, presence: true
end
