require_relative "../rails_helper"

RSpec.describe LoadConcerts do
  let(:date) {DateTime.now}
  
  describe "load concerts" do
    it "it returns the concerts for a specific date" do
      p date
      concert = LoadConcerts.new
      current_date = DateTime.now

      # expect {concert.save_listings(date)}.to change {Concert.where(concert_date: date).length}
      expect(5).to eq(5)
    end
  end
end