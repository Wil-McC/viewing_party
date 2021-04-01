class MoviesFacade
  def self.details_for(movie_api_id)
    TMDBService.details_for(movie_api_id)
  end

  def self.cast_for(movie_api_id, limit)
    @movie_cast = TMDBService.cast_for(movie_api_id, limit)
  end

  def self.reviews_for(movie_api_id)
    @movie_reviews = TMDBService.reviews_for(movie_api_id)
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
