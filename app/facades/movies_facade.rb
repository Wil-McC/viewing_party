class MoviesFacade
  def self.details_for(movie_api_id)
    TMDBService.details_for(movie_api_id)
  end

  def self.cast_for(movie_api_id, limit)
    TMDBService.cast_for(movie_api_id, limit)
  end

  def self.reviews_for(movie_api_id)
    TMDBService.reviews_for(movie_api_id)
  end

  def self.where_to_watch(movie_api_id)
    TMDBService.where_to_watch(movie_api_id)
  end

  def self.movies_top
    TMDBService.movies_top
  end

  def self.movies_trending
    TMDBService.movies_trending
  end

  def self.movie_search(query)
    TMDBService.movie_search(query)
  end
end
