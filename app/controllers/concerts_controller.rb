class ConcertsController < ApplicationController

  def index
    concert_object = LoadConcerts.new
    @concerts = concert_object.concert_logic(params)
    if params[:date] == nil 
      @date = Time.now.strftime("%Y-%m-%d")
    else
      @date = params[:date]
    end
  end

  def about
  end

end
