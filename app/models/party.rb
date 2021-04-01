class Party < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  has_many :invitees

  validates :user_id,
            :movie_id,
            :start_time, presence: true
end
