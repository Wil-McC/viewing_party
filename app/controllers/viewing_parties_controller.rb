class ViewingPartiesController < ApplicationController

  def new
    @party = Party.new
  end


  def create
    require "pry"; binding.pry
  end
end
