require_relative "../rails_helper"

RSpec.describe LoadConcerts, :vcr do
  let(:date) {DateTime.new(2017,12,2)}
  let(:concert) {LoadConcerts.new}

  describe "create_connection" do
    it "it returns a faraday connection" do
      connection = concert.create_connection
      expect(connection.class).to eq(Faraday::Connection)
    end
  end
  
  describe "get_listings" do
    it "it returns the concerts for a specific date" do
      listing = concert.get_listings(date)
      expect(listing[0]['title']).to eq("Queens of the Stone Age w/ Run the Jewels, Biffy Clyro")
    end
  end

  describe "get_artist" do
    it "it returns a json of data on an artist taking in a permalink" do
      artist_data = concert.get_artist("artists/queens-of-the-stone-age")
      expect(artist_data['title']).to eq("Queens Of The Stone Age")
    end
  end


end



