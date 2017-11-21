require 'faraday'
require 'faraday_middleware'
require 'vcr'


VCR.configure do |c|
  c.cassette_library_dir = 'vcr_cassettes'
  c.hook_into :faraday
  # c.configure_rspec_metadata!
end

class LoadConcerts

  def save_listings(date)

    VCR.use_cassette('events') do
      conn = Faraday.new(:url => 'http://do312.com/') do |faraday|
        faraday.request  :url_encoded
        faraday.response :json       
        faraday.adapter  Faraday.default_adapter 
      end
      response = conn.get 'events/2017/11/21.json'
      response.body['events'].each do | event |
        # ticket_price = event['ticket_info'].match(/\$([0-9]*)/).captures[0].to_i
        features = {title: event['title'], description: event['description'], ticket_info: event['ticket_info'], api_id: event['id']}
        Concert.create(features)
        
    
      end
    # p response
    # Concert.create ({title: 'blah', description: "this is a test", ticket_info: "$45", api_id: "23432"})
    end
    
  end

end