
# require_relative 'load_concerts'
# require 'vcr'



# sample = LoadConcerts.new
# sample.save_listings

# p Concert.new

require_relative 'twitter'
testtwit = LoadTweets.new
p testtwit.setStream("bieber")


