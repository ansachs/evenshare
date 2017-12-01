require_relative "../rails_helper"
require 'vcr'

RSpec.describe LoadConcerts do
  let(:tag) {"rhcp"}

  describe "load tweets", :vcr do
    it "it returns tweets for the red hot chilli peppers" do
      tweet_service = LoadTweets.new
      tweet = tweet_service.setStream(tag)
      p tweet[0].text
      expect(tweet[0].text.downcase).to include('rhcp')
    end
  end
end