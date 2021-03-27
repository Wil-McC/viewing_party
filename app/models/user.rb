class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :invitees
  has_many :parties

  has_secure_password
  validates :email, uniqueness: true, presence: true

  def self.by_email(email)
    User.where(email: email).first
  end
end
