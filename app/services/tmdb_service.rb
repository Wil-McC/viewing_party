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

      data = res_parse(response)
      arr << data[:results]
    end
  end

  def self.movies_top
    top_forty.flat_map do |page|
      create_movie_structs(page)
    end
  end

  def self.string_cleaner(string)
    string.gsub(/[ ]/, '+')
  end

  def self.search_call(string, page = 1)
    res = @@conn.get('3/search/movie') do |req|
      req.params['query'] = string_cleaner(string)
      req.params['page'] = page
    end
    res_parse(res)[:results]
  end

  def self.res_parse(response)
    json = response.body
    JSON.parse(json, symbolize_names: true)
  end

  def self.movie_search(string)
    result = [search_call(string), search_call(string, 2)]
    result.flat_map do |page|
      create_movie_structs(page)
    end
  end

  def self.details_for(id)
    result = @@conn.get("3/movie/#{id}")
    # TODO will crash if result is ''
    data = res_parse(result)

    create_details_struct(data)
  end

  def self.cast_for(id, limit)
    return [] if limit < 1
    result = @@conn.get("3/movie/#{id}/credits")
    # TODO will crash if result is ''
    data = res_parse(result)

    create_cast_structs(data, limit)
  end

  def self.reviews_for(id)
    result = @@conn.get("3/movie/#{id}/reviews")
    # TODO will crash if result is ''
    data = res_parse(result)

    create_review_structs(data[:results])
  end

  def self.trending_40_call(page = 1)
    res = @@conn.get('3/trending/movie/week') do |req|
      req.params['page'] = page
    end
    res_parse(res)[:results]
  end

  def self.movies_trending
    result = [trending_40_call, trending_40_call(2)]
    result.flat_map do |page|
      create_movie_structs(page)
    end
  end

  def self.where_to_watch(id)
    endpoint = "3/movie/#{id}/watch/providers"
    res = @@conn.get(endpoint)
    data = res_parse(res)[:results]
    if data.length > 0
      create_wtw_struct(data[:US][:link])
    else
      return nil
    end
  end

  private

  def self.create_wtw_struct(path)
    OpenStruct.new({
      link: path
    })
  end

  def self.create_movie_structs(results)
    results.map do |movie|
      OpenStruct.new({
        id: movie[:id],
        title: movie[:title],
        rating: movie[:vote_average]
      })
    end
  end

  def self.create_details_struct(data)
    OpenStruct.new({
      api_id: data[:id],
      title: data[:title],
      vote_average: data[:vote_average],
      runtime: data[:runtime],
      genres: parse_genres(data[:genres]),
      summary: data[:overview]
    })
  end

  def self.parse_genres(genres)
    genres.map do |genre|
      genre[:name]
    end
  end

  def self.create_cast_structs(data, limit)
    cast = []
    data[:cast].each_with_index do |cast_member, i|
      break if i == limit
      cast << OpenStruct.new({
        actor: cast_member[:name],
        character: cast_member[:character]
      })
    end

    cast
  end

  def self.create_review_structs(data)
    data.map do |review|
      OpenStruct.new({
        author: review[:author],
        content: review[:content]
      })
    end
  end
end
