class MediaLinksController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_user
  # before_action :set_chat_box
  # after_create_commit { MessageBroadcastJob.perform_later self }
  # before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
    @referring_concert = params[:concert_id]
    @user_media = @user.media_links
  end

  def create
    # binding.pry
    user_media = params['user_media']['link']
    if current_user == nil
      redirect_to concert_shared_experiences_path, notice: 'must login in to add media'
    elsif ( user_media.match? (/^https:\/\/.*embed.*/) )
      media = MediaLink.new(media_params)
      # binding.pry
      # media.concert_id = @concert.concert_id
      media.user_id = current_user.id
      # binding.pry
      if media.save
        # binding.pry 
        redirect_to concert_shared_experiences_path(concert_id: params['user_media']['concert_id'])
      else 
        # binding.pry 
        redirect_to concert_shared_experiences_path, notice: 'link did not save'
      end
    else
      redirect_to concert_shared_experiences_path, notice: 'invalid link'
    end
  end
    
  def destroy
    # binding.pry
    MediaLink.find(params[:id]).destroy
    redirect_to user_media_links_path, notice: 'item successfully deleted'
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def message_params  
    params['message'].permit(:statement, :chat_box_id)
  end

  def media_params
    params['user_media'].permit(:concert_id, :link)
  end

  def render_message(message) 
      ApplicationController.renderer.render(partial: 'chats/chat', locals: { message: message }) 
      # binding.pry
  end
end
