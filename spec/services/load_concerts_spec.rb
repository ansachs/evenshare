require_relative "../rails_helper"

RSpec.describe LoadConcerts do
  # let(:product) { Product.create!(manufacturer: manufacturer, name: "Air Jordan 9", price: 110, sku: 'sure') }
  # let(:manufacturer) { Manufacturer.create!(name: "Nike", description: "Just do it.") }
  # let(:user) { User.create!(email: "test@test.com", password: "abcd1234") }

  describe "save_listings" do
    it "saves the listings for a specific date" do
      # target_product = product
      # params: { manufacturer_id: manufacturer.id, id: product.id }
      
      # expect { delete :destroy, params }.to change { manufacturer.products.count }.by(-1)
      concert = LoadConcerts.new
      expect {concert.save_listings('a date')}.to change {Concert.all.count}.by(1) 
      p Concert.all

    end
  end
end