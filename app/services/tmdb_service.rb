require 'faraday'
require 'json'

class TMDBService
  def self.get_data(endpoint)
    response = Faraday.get(endpoint)
    data = response.body
    JSON.parse(data, symbolize_names: true)
  end

  def self.top_forty
    counters = [1, 2]

    counters.reduce([]) do |arr, count|
      endpoint = "https://api.themoviedb.org/3/movie/top_rated?api_key=7977257dcd366127c720211a9f03229b&page=#{count}"
      json = get_data(endpoint)
      arr << json[:results]
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
