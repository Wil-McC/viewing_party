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
      json = response.body
      data = JSON.parse(json, symbolize_names: true)
      arr << data[:results]
      arr
    end
  end

  def self.movies
    counters = [0, 1]
    counters.each_with_object({}) do |count, hash|
      top_forty[count].each do |movie|
        hash[movie[:id]] = [movie[:title], movie[:vote_average]]
      end
    end
  end

  def self.string_cleaner(string)
    string.gsub(/[ ]/, '+')
  end

  # start sandbox

  def self.search_call(endpoint, string, page = 1)
    @@conn.get(endpoint) do |req|
      req.params['query'] = string_cleaner(string)
      req.params['page'] = page
    end
  end

  def self.res_parse(response)
    json = response.body
    JSON.parse(json, symbolize_names: true)
  end

  def self.movie_search(string)
    endpoint = '3/search/movie'
    response = search_call(endpoint, string)
    data = res_parse(response)

    acc = []
    if data[:total_pages] > 1
      acc << data[:results]
      data = res_parse(search_call(endpoint, string, 2))
      acc << data[:results]
    elsif data[:total_pages] == 1
      acc << data[:results]
    elsif data[:total_pages] == 0
      return acc
    end

    acc
  end

  def self.results(data)
    if data.length == 2
      counters = [0, 1]
      counters.each_with_object({}) do |count, hash|
        data[count].each do |movie|
          hash[movie[:id]] = [movie[:title], movie[:vote_average]]
        end
      end
    elsif data.length == 1
      hash = {}
      data[0].each_with_object({}) do |movie, hash|
        hash[movie[:id]] = [movie[:title], movie[:vote_average]]
      end
    elsif data.length == 0
      'Your search returned no results'
    end
  end

  # end sandbox

  # def self.movie_search(string)
    # endpoint = '3/search/movie'

    # response = @@conn.get(endpoint) do |req|
      # req.params['query'] = string_cleaner(string)
    # end

    # json = response.body
    # data = JSON.parse(json, symbolize_names: true)
  # end
end
