
require 'twitter'

class LoadTweets 

  def initialize()
    @client = self.createClient()
  end

  def createClient
    return Twitter::REST::Client.new do |config|
      config.consumer_key        = "boX4lrChqQi3LB9fJYSfYnzbT"
      config.consumer_secret     = Rails.application.secrets.twitter_consumer_secret
      config.access_token        = "935516830508216321-AiV47Wioo6Uw97srLznYtUG5lBk7yri"
      config.access_token_secret = Rails.application.secrets.twitter_access_token_secret
    end
  end

  def setStream(tag)
    @client.search("##{tag}", lang: "en", result_type: "recent").take(5) 
  end

end
