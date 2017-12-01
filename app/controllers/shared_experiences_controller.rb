class SharedExperiencesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :create, :tweet_feed]
  before_action :set_concert
  # before_action :set_chat_box
  # after_create_commit { MessageBroadcastJob.perform_later self }
  # before_action :set_location, only: [:show, :edit, :update, :destroy]

  def index
        
    # if (@concert.chat_box == nil)
    #   ChatBox.create()
    # end
    @chat_box = ChatBox.find_or_create_by(concert_id: @concert.id)
    @messages = Message.where(chat_box_id: @chat_box.id)
    # binding.pry 
    @media = MediaLink.where(concert_id: @concert.id)
    @new_media = MediaLink.new
    # @message = Message.new
    # binding.pry 

  end



  def media_search
    possible_user = User.where(name: params[:query])
    if possible_user.length > 0
      # binding.pry 
      redirect_to user_media_links_path(user_id: possible_user[0].id, concert_id: @concert.id)
    else
      redirect_to concert_shared_experiences_path, notice: 'user does not exist'
    end
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
        ActionCable.server.broadcast "room", chat: render_message(message)
        
        # redirect_to concert_shared_experiences_path
      else 
        # redirect_to concert_shared_experiences_path
      end
    end
  end

  def tweet_feed
    # binding.pry 

    # testtwit = LoadTweets.new
    # outarray =[]
    # twitter_hash = @concert.title.gsub(/[^A-Za-z0-9]/, '_')
    # tweets = testtwit.setStream("rhcp")
    # # p tweets.length
    # tweets.each do |tweet|
    #   Tweet.create_with(user: tweet.user, message: tweet.text, concert_id: @concert.id).find_or_create_by(twitterID: tweet.id)
    # end

    # Tweet.create_with(user: current_tweet.user, message: current_tweet.text, concert_id: @concert_id).find_or_create_by(twitterID: current_tweet.id)
  #   end
        # respond_to do |format|
        #   format.json {render json: {data: outarray} }
        # end
    # render formats: :json
    # p Tweet.first.to_json 
    render json: Tweet.first(10)
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
      # binding.pry
  end

end
