class Party < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  has_many :invitees

  validates_presence_of :user_id,
                        :movie_id,
                        :start_time
end
