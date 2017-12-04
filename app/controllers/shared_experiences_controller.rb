class SharedExperiencesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :create, :tweet_feed]
  before_action :set_concert
 
  def index
    @chat_box = ChatBox.find_or_create_by(concert_id: @concert.id)
    @messages = Message.where(chat_box_id: @chat_box.id)
    @media = MediaLink.where(concert_id: @concert.id)
    @new_media = MediaLink.new
  end

  def media_search
    possible_user = User.where(name: params[:query])
    if possible_user.length > 0
      redirect_to user_media_links_path(user_id: possible_user[0].id, concert_id: @concert.id)
    else
      redirect_to concert_shared_experiences_path, notice: 'user does not exist'
    end
  end

  
  def create
    if current_user == nil
      redirect_to concert_shared_experiences_path, notice: 'must login in to use chat'
    elsif params['message']['statement'].match?(/^https:\/\/www.youtube.com\/embed\/[0-9a-zA-Z_\-]*$/)
    params['message']['link'] = params['message'].delete('statement')
    new_link = MediaLink.new(media_params)
    new_link.user_id = current_user.id
    new_link.media_type = "video"
    new_link.concert_id = @concert.id
    new_link.save
    ActionCable.server.broadcast "room_#{@concert.id}", media: render_video(new_link)
        render body: nil
    else

      message = Message.new(message_params)
      message.user_id = current_user.id
      message.save

      ActionCable.server.broadcast "room_#{@concert.id}", chat: render_message(message)
        render body: nil
    end
  end

  def tweet_feed
    current_band = @concert.bands.first
    recent_tweet = Tweet.where(concert_id: @concert.id).last
    if recent_tweet == nil || Time.now - recent_tweet.created_at > 60
      testtwit = LoadTweets.new
      twitter_hash = @concert.title.gsub(/[^A-Za-z0-9]/, '_')
      tweets = testtwit.setStream(current_band.twitter)
      tweets.each do |tweet|
        Tweet.create_with(user: tweet.user, message: tweet.text, concert_id: @concert.id).find_or_create_by(twitterID: tweet.id)
      end
    end
    # binding.pry
    render json: Tweet.where(concert_id: @concert.id).last(10).reverse
  end

  private

  def set_concert
    @concert = Concert.find(params[:concert_id])
  end

  def message_params  
    params['message'].permit(:statement, :chat_box_id)
  end

  def media_params
    params['message'].permit(:link)
  end

  def render_message(message) 
    ApplicationController.renderer.render(partial: 'chats/chat', locals: { message: message }) 
      # binding.pry
  end

  def render_video(new_link) 
    ApplicationController.renderer.render(partial: 'videos/video', locals: { video: new_link }) 
      # binding.pry
  end

end
