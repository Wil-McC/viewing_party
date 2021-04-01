class MoviesController < ApplicationController
  before_action :require_login

  def index
    if params[:query] == 'top_forty'
      @results = MoviesFacade.movies_top
    elsif params[:query] == 'weekly_trending_api'
      @results = MoviesFacade.movies_trending
    else
      @results = MoviesFacade.movie_search(params[:query])
    end
  end

  def show
    @movie_details = MoviesFacade.details_for(params[:id])
    @movie_cast = MoviesFacade.cast_for(params[:id], 10)
    @movie_reviews = MoviesFacade.reviews_for(params[:id])
    @where_to_watch = MoviesFacade.where_to_watch(params[:id])
  end
end
