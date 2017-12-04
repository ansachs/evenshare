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

  describe "concert logic" do
    it "it determines if a date is passed in params, if that day has already been queried, it will return objects from the database" do
      Concert.create(title: 'Red Hot Chili Peppers', description: '90s rock', ticket_info: 'free', api_id: 9999, concert_date: DateTime.new(1999,12,5,15,30,0))
      Concert.create(title: 'monty crew', description: 'more bad 80s bands', ticket_info: 'free', api_id: 9999, concert_date: DateTime.new(1999,12,5,1,30,0))
      listing = concert.concert_logic({"date" => '1999-12-05'})
      expect(listing[0]['title']).to eq('Red Hot Chili Peppers')
      
    end
  end

  describe "concert logic" do
    it "it determines if a date is passed in params, if a new days is queried, it will return concerts for that date" do
      new_date = DateTime.new(2017,12,6).strftime('%Y-%m-%d')
      listing = concert.concert_logic({"date" => new_date})
      # p listing[0]
      expect(listing[0]['concert_date'].strftime('%Y-%m-%d')).to eq('2017-12-06')
    end
  end

  describe "get_band" do
    it "it returns a json of data on an artist taking in a permalink" do
      artist_data = concert.get_band("artists/queens-of-the-stone-age")
      expect(artist_data['title']).to eq("Queens Of The Stone Age")
    end
  end


end



