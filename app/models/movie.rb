class Movie < ApplicationRecord
  has_many :parties

  validates :api_id,
            :name, presence: true
end
