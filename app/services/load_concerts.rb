require 'faraday'
require 'faraday_middleware'
require 'vcr'


# VCR.configure do |c|
#   c.cassette_library_dir = 'vcr_cassettes'
#   c.hook_into :faraday
#   # c.configure_rspec_metadata!
# end

class LoadConcerts

  def save_listings(date)

    # VCR.use_cassette('events') do
    # if Concert.where(concert_date: date) 
      format_date = date.strftime('%Y/%m/%d')
      conn = Faraday.new(:url => 'http://do312.com/') do |faraday|
        faraday.request  :url_encoded
        faraday.response :json       
        faraday.adapter  Faraday.default_adapter 
      end
      response = conn.get "events/#{format_date}.json"
      response.body['events'].each do | event |
        # ticket_price = event['ticket_info'].match(/\$([0-9]*)/).captures[0].to_i
        # event['artists'].each do |artist|
        #   # if Artist.where(name: artist['title']) == nil
        #   #   artist_response = conn.get artist.data_path
        #   #   puts artist.twitter
        #   # end
        #   p artist
        # end
        # Artist.create_with(user: tweet.user, message: tweet.text, concert_id: @concert.id).find_or_create_by(twitterID: tweet.id)
        # Concert.create_with(title: event['title'], description: event['description'], ticket_info: event['ticket_info']).find_or_create_by(api_id: event['id'])  
        p event.keys
        p event.begin_time
        
    
      end
    # p response
    # Concert.create ({title: 'blah', description: "this is a test", ticket_info: "$45", api_id: "23432"})
    # end
    
  end

end