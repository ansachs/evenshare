# require 'faraday'
# require 'faraday_middleware'
require 'twitter'

class LoadTweets 
  # attr_reader :client

  def initialize()
    @client = self.createClient()
    # @concert_id = concert_id
  end

  def createClient
    return Twitter::REST::Client.new do |config|
      config.consumer_key        = "boX4lrChqQi3LB9fJYSfYnzbT"
      config.consumer_secret     = Rails.application.secrets.twitter_consumer_secret
      config.access_token        = "935516830508216321-AiV47Wioo6Uw97srLznYtUG5lBk7yri"
      config.access_token_secret = Rails.application.secrets.twitter_access_token_secret
    end
  end

  # def saveTweet(current_tweet)
  #   p "test"
  #   if current_tweet != nil
  #     Tweet.create_with(user: current_tweet.user, message: current_tweet.text, concert_id: @concert_id).find_or_create_by(twitterID: current_tweet.id)
  #   end
  # end

  def setStream(tag)
    @client.search("##{tag}", lang: "en").take(5) 
  end

end
