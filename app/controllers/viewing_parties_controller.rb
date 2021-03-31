require 'ostruct'

class ViewingPartiesController < ApplicationController
  def new
    @movie = movie_info
    @party = Party.new
  end


  def create
  end

  private

  def movie_info_params
    @_movie_params ||= params.require(:movie).permit(:api_id, :title, :runtime)
  end

  def movie_info
    OpenStruct.new({
      api_id: movie_info_params[:api_id],
      title: movie_info_params[:title],
      runtime: movie_info_params[:runtime]
    })
  end
end
