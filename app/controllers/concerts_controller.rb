class ConcertsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
     @concerts = Concert.all
  end

end
