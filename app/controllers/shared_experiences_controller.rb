class SharedExperiencesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :create]
  before_action :set_concert
  # before_action :set_chat_box
  # after_create_commit { MessageBroadcastJob.perform_later self }
  # before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
    # binding.pry
    # if (@concert.chat_box == nil)
    #   ChatBox.create()
    # end
    @chat_box = ChatBox.find_or_create_by(concert_id: @concert.id)
    @messages = Message.where(chat_box_id: @chat_box.id)
    # @message = Message.new
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
    if current_user == nil
      redirect_to concert_shared_experiences_path, notice: 'must login in to use chat'
    else 
      message = Message.new(message_params)
      # binding.pry
      message.user_id = current_user.id
      # binding.pry
      if message.save
      
        # ActionCable.server.broadcast 'room',
        #   message: message.statement,
        #   user: current_user.email
        # head :ok
        ActionCable.server.broadcast "room", message: render_message(message) 
        redirect_to concert_shared_experiences_path
      else 
        redirect_to concert_shared_experiences_path
      end
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
      params['message'].permit(:statement, :chat_box_id)
  end

  def render_message(message) 
      ApplicationController.renderer.render(partial: 'chats/chat', locals: { message: message }) 
      binding.remote_pry
  end

end
