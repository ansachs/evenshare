class ConcertsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    concert_object = LoadConcerts.new
    @concerts = concert_object.concert_logic(params)
  end

end
