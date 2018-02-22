class ConcertsController < ApplicationController

  def index
    concert_object = LoadConcerts.new
    @concerts = concert_object.concert_logic(params)
  end

  def about
  end

end
