class SharedExperiencesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :create]
  before_action :set_concert
  # after_create_commit { MessageBroadcastJob.perform_later self }
  # before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
    @chats = Chat.where(concert_id: @concert.id)
    @message = Chat.new
    # binding.pry
  end

  def show
    
  end

  def new
    # @location = Location.new
  end

  def edit
  end

  def create
    # binding.pry
    message = Chat.new(message_params)
    message.user_id = 1
    # binding.pry
    if message.save
      # do some stuff
      # binding.pry
      ActionCable.server.broadcast 'room',
        message: message.statement,
        user: message.user_id
      head :ok
    else 
      redirect_to concert_shared_experiences_path
    end
  end
    
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

  def set_concert
    @concert = Concert.find(params[:concert_id])
  end

  def message_params
    # binding.pry   
      params['/concerts/1/shared_experiences'].permit(:statement, :concert_id)
  end

end
