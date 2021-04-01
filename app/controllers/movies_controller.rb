class MoviesController < ApplicationController
  before_action :require_login

  def index
    if params[:query] == 'top_forty'
      @results = TMDBService.movies_top
    elsif params[:query] == 'weekly_trending_api'
      @results = TMDBService.movies_trending
    else
      @results = TMDBService.movie_search(params[:query])
    end
  end

  def show
    @movie_details = TMDBService.details_for(params[:id])
    @movie_cast = TMDBService.cast_for(params[:id], 10)
    @movie_reviews = TMDBService.reviews_for(params[:id])
    @where_to_watch = TMDBService.where_to_watch(params[:id])
  end
end
