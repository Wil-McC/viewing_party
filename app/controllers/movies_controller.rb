class MoviesController < ApplicationController
  before_action :require_login

  def index
    @results = if params[:query] == 'top_forty'
                 MoviesFacade.movies_top
               elsif params[:query] == 'weekly_trending_api'
                 MoviesFacade.movies_trending
               else
                 MoviesFacade.movie_search(params[:query])
               end
  end

  def show
    @movie_details = MoviesFacade.details_for(params[:id])
    @movie_cast = MoviesFacade.cast_for(params[:id], 10)
    @movie_reviews = MoviesFacade.reviews_for(params[:id])
    @where_to_watch = MoviesFacade.where_to_watch(params[:id])
  end
end
