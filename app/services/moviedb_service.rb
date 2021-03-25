class MovieDBService < ApiService
  def self.top_forty
    endpoint = 'https://api.themoviedb.org/3/movie/top_rated?api_key=7977257dcd366127c720211a9f03229b'
    json = get_data(endpoint)
    json.each do |movie|
      require "pry"; binding.pry
    end
    # 'https://api.themoviedb.org/3/movie/top_rated?api_key=7977257dcd366127c720211a9f03229b&page=1'
  end
  require "pry"; binding.pry
end
