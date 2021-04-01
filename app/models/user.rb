class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :invitations, class_name: 'Invitee'
  has_many :hosted_parties, class_name: 'Party'
  has_many :invited_parties, through: :invitations, source: :party

  has_secure_password
  validates :email, uniqueness: true, presence: true

  def self.by_email(email)
    User.where(email: email).first
  end

  def viewing_parties_involving_me
    hosted_parties.to_a.concat(invited_parties)
  end
end
