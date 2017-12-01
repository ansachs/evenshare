require 'rails_helper'

RSpec.describe SharedExperiencesController, type: :controller do
  render_views

    let(:user) { User.create!(name: "sam", email: "sam@test.com", password: "abcd1234") }

    let(:concert) {Concert.create(title: 'van halen', description: '80s rock', ticket_info: 'free', api_id: 9999)}

    # let(:valid_attributes) {
    #   {country: 'United States', city: 'Chicago', address: '121 Monroe Ave, chicago, il', manager: Faker::AquaTeenHungerForce.character, phone: Faker::PhoneNumber.cell_phone}
    # }

    # let(:invalid_attributes) {
    #   { country: 'United States', city: 'Chicago', address: '', manager: Faker::AquaTeenHungerForce.character, phone: Faker::PhoneNumber.cell_phone }
    # }

  before { sign_in(user) }

  describe "GET #tweet_feed" do
    it "updated tweets in database" do
      # location = Location.create! valid_attributes

      get :tweet_feed, params: {concert_id: concert.id }
      # print json.parse(response.body)

      expect(JSON.parse(response.body).length).to eq(5)
    end
  end

end
