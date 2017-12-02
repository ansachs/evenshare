require_relative "../rails_helper"



RSpec.describe LoadTweets, :vcr do
# VCR.use_cassette('test_data', :record => :new_episodes) do
  let(:tag) {"rhcp"}
  let(:twitter_client) {LoadTweets.new}

  describe "create client" do
    it "it returns a twitter class client" do
      p twitter_client.class
      expect(twitter_client.createClient.class).to eq(Twitter::REST::Client)
    end
  end

  describe "setStream" do
    it "it returns the five most recent tweets given a hashtag" do
      # tweet_service = LoadTweets.new
      # p twitter_client
      tweets = twitter_client.setStream(tag)
      p tweets[0].text  
      expect(tweets[0].text.downcase).to include('rhcp')
    end
  end
end