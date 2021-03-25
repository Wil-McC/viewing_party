class Movie < ApplicationRecord
  has_many :parties

  validates_presence_of :api_id,
                        :name
end
