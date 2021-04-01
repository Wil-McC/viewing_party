require 'ostruct'

class ViewingPartiesController < ApplicationController
  def new
    @movie = movie_info
    @party = Party.new
  end


  def create
    saved_movie = Movie.find_or_create_by(api_id: movie_params[:api_id]) do |movie|
      movie.name = movie_params[:title]
    end

    # require "pry"; binding.pry
    # if party_params[:duration] < movie_params[:runtime]
    #   flash[:time] = 'The duration of the party cannot be less than the runtime of the movie'
    #   # <%= form.hidden_field 'movie[api_id]', value: @movie.api_id %>
    #   # <%= form.hidden_field 'movie[title]', value: @movie.title %>
    #   # <%= form.hidden_field 'movie[runtime]'
    #   # redirect_to new_party_path, movie_params[:api_id], movie_params[:title], movie_params[:runtime] && return
    #   @movie = OpenStruct.new({
    #         api_id: movie_params[:api_id],
    #         title: movie_params[:title],
    #         runtime: movie_params[:runtime]
    #       })
    #   render :new && return
    # else
      new_party = Party.new(user_id: current_user.id, movie_id: saved_movie.id, start_time: party_params[:start_time], duration: party_params[:duration])
      new_party.save
    # end


    if params.has_key?(:friend_user_ids)
      params[:friend_user_ids].each do |id|
        invited = Invitee.new(user_id: id, party_id: new_party.id)
        invited.save
      end
    end

    redirect_to dashboard_path
  end

  private

  def movie_info_params
    params.require(:movie).permit(:api_id, :title, :runtime)
  end

  def movie_info
    OpenStruct.new({
      api_id: movie_info_params[:api_id],
      title: movie_info_params[:title],
      runtime: movie_info_params[:runtime]
    })
  end

  def movie_params
    params.require(:party).require(:movie).permit(:api_id, :title, :runtime)
  end

  def party_params
    params.require(:party).permit(:start_time, :duration)
  end


end
