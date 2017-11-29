# require 'faraday'
# require 'faraday_middleware'
require 'twitter'



client = Twitter::Streaming::Client.new do |config|
  config.consumer_key        = "boX4lrChqQi3LB9fJYSfYnzbT"
  config.consumer_secret     = "kj2NTBpt6IxZNqtW1wWz7VCcpr7uYwJWzPKCppS5ZwbSaHhijq"
  config.access_token        = "935516830508216321-AiV47Wioo6Uw97srLznYtUG5lBk7yri"
  config.access_token_secret = "37z2jQLOfZXczLGGWMfp7VKHv0keJjs2YyCdd2885sVB8"
end

topics = ["coffee", "tea"]
client.filter(track: "justinbieber") do |object|
  puts object.text if object.is_a?(Twitter::Tweet)
end