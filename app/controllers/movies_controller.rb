class MoviesController < ApplicationController
  before_action :require_login

  def index
    if params[:query] == 'top_forty'
      @results = TMDBService.movies
    elsif params[:query] == 'weekly_trending_api'
      @results = TMDBService.trending_weekly
    else
      @results = TMDBService.results(params[:query])
    end
  end

  def show
    @movie_details = TMDBService.details_for(params[:id])
    @movie_cast = TMDBService.cast_for(params[:id], 10)
    @movie_reviews = TMDBService.reviews_for(params[:id])
  end
end
