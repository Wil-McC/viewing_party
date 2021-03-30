class MoviesController < ApplicationController
  def index
    if params[:query] == "top_forty"
      @results = TMDBService.movies
    else
      @results = TMDBService.results(params[:query])
    end
  end
end
