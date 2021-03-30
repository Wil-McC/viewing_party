class MoviesController < ApplicationController
  before_action :require_login

  def index
    if params[:query] == "top_forty"
      @results = TMDBService.movies
    else
      @results = TMDBService.results(params[:query])
    end
  end

  def show
  end
end
