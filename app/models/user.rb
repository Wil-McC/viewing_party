class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships
  # has_many :invitees, as: :invitations
  has_many :parties
  has_many :invitations, foreign_key: 'user_id', class_name: 'Invitee'
  has_many :invited_to_parties, through: :invitations, source: :party

  has_secure_password
  validates :email, uniqueness: true, presence: true

  def self.by_email(email)
    User.where(email: email).first
  end

  def viewing_parties_involving_me
    parties.concat(invited_to_parties)
  end
end
