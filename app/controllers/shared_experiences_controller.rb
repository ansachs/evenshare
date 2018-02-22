class SharedExperiencesController < ApplicationController
  before_action :set_concert
  before_action :authenticate_user!, only: [:create]
  
 
  def index
    @chat_box = ChatBox.find_or_create_by(concert_id: @concert.id)
    @messages = Message.where(chat_box_id: @chat_box.id)
    @media = MediaLink.where(concert_id: @concert.id)
    # @new_media = MediaLink.new
    @tweets = Tweet.where(concert_id: @concert.id).last(5).reverse
    # binding.pry
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

    youtube_reg = [
      /^https:\/\/www.youtube.com\/embed\/[0-9a-zA-Z_\-]*$/,
      /^https:\/\/youtu.be\/[0-9a-zA-Z_\-]*$/
      ]
    # if current_user == nil
    #   redirect_to concert_shared_experiences_path, notice: 'must login in to use chat'

    if params['message']['statement'].strip.match?(Regexp.union(youtube_reg))

      if params['message']['statement'].strip.match?(youtube_reg[1])
        embed = params['message']['statement'].strip.match(/^https:\/\/youtu.be\/([0-9a-zA-Z_\-]*$)/)[1]
        params['message']['link'] = "https://www.youtube.com/embed/" + embed 
      else
        params['message']['link'] = params['message']['statement'].strip
      end


      record = MediaLink.find_or_initialize_by(media_params)
      
      if record.new_record?
        record.user_id = current_user.id
        record.media_type = "video"
        record.concert_id = @concert.id
        record.save
        ActionCable.server.broadcast "room_#{@concert.id}", media: render_video(record)
      else
        message = Message.new({statement: "video already posted: " + record.link})
        message.user_id = 1
        message.save
        ActionCable.server.broadcast "room_#{@concert.id}", chat: render_message(message)
      end

      render body:nil

    else

      message = Message.new(message_params)
      message.user_id = current_user.id
      message.save

      ActionCable.server.broadcast "room_#{@concert.id}", chat: render_message(message)
        render body: nil
    end
  end

  def tweet_feed
    top_band_with_twitter = @concert.bands.where.not('twitter': nil)
    if top_band_with_twitter == []
      current_handle = @concert.title.gsub(/[^A-Za-z0-9]/, '_')
    else
      current_handle = top_band_with_twitter.first.twitter
    end

    recent_tweet = Tweet.where(concert_id: @concert.id).last
    if recent_tweet == nil || Time.now - recent_tweet.created_at > 60
      testtwit = LoadTweets.new
      tweets = testtwit.setStream(current_handle)
      new_tweet_array = []
      tweets.each do |tweet|
        Tweet.find_or_initialize_by(twitterID: tweet.id) do |new_tweet|
          new_tweet.update_attributes({user: tweet.user, message: tweet.text, concert_id: @concert.id})
          new_tweet.save
          new_tweet_array << new_tweet
          end
      end
    end
    if new_tweet_array && new_tweet_array.length > 0
      render json: new_tweet_array.reverse
    else
      render body: nil
    end
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
  end

  def render_video(new_link) 
    ApplicationController.renderer.render(partial: 'videos/video', locals: { video: new_link }) 
  end

end
