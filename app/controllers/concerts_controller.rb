class ConcertsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
    binding.pry
    concert_object = LoadConcerts.new
    concert_object.concert_logic(params)
     
    # concert.save_listings('test')
    @concerts = Concert.where(concert_date: )
  end
    
  end

  def show
    
  end

  def new
    # @location = Location.new
  end

  def edit
  end

  # def create
  #   @location = Location.new(location_params)

  #   if @location.save
  #     send_alert = TwilioMessage.new(@location.address, "", current_user)
  #     # send_alert.create_address
  #     redirect_to locations_path, notice: 'Location was successfully created.'
  #   else
  #     render :new
  #   end
  # end

  def update
    # binding.pry
  #   if @location.update(location_params)
  #     redirect_to locations_path, notice: 'Location was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   @location.destroy
  #   redirect_to locations_path, notice: 'Location was successfully destroyed.'
  end

  private

  def set_location
    # @location = Location.find(params[:id])
  end

  def location_params
    # params.require(:location).permit(:city, :country, :address, :manager, :phone)
  end

end
