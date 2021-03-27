require 'faraday'
require 'json'

class TMDBService < ApiService

  def self.top_forty
    counters = [1, 2]
    counters.reduce([]) do |arr, count|
      endpoint = '3/movie/top_rated'
      response = @@conn.get(endpoint) do |req|
        req.params['page'] = count
      end
      thing = response.body
      thing2 = JSON.parse(thing, symbolize_names: true)
      arr << thing2[:results]
      arr
    end
  end

  def self.movies
    counters = [0, 1]

    counters.each_with_object({}) do |count, hash|
      top_forty[count].each do |movie|
        hash[movie[:title]] = movie[:vote_average]
      end
    end
  end
end
