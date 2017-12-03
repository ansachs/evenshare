require 'faraday'
require 'faraday_middleware'
require 'vcr'


# VCR.configure do |c|
#   c.cassette_library_dir = 'vcr_cassettes'
#   c.hook_into :faraday
#   # c.configure_rspec_metadata!
# end

class LoadConcerts
  def initialize
    @connection = self.create_connection
  end

  def create_connection
    conn = Faraday.new(:url => 'http://do312.com/') do |faraday|
        faraday.request  :url_encoded
        faraday.response :json       
        faraday.adapter  Faraday.default_adapter 
      end
  end

  def concert_logic(params)
    if params['date'] 
      # converted_date = (params['date'].to_time + 5.hours).to_datetime
      return found_concerts = self.get_listings(params['date'].to_datetime)
    elsif Concert.where(concert_date: DateTime.now.beginning_of_day..DateTime.now).length == 0
        # concert_object = LoadConcerts.new
      return todays_concerts = self.get_listings(Time.now)
      # self.store_concerts(todays_concerts)
    else
      return Concert.where(concert_date: params['date']..params['date'].to_time + 24)
    end
  end

  def get_listings(date)

      format_date = date.strftime('%Y/%m/%d')
      response = @connection.get "events/#{format_date}.json"
      return response.body['events']
      # response.body['events'].each do | event |
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
        # p event.keys
        # p event.begin_time
        
        
      
    # p response
    # Concert.create ({title: 'blah', description: "this is a test", ticket_info: "$45", api_id: "23432"})
    # end
    
  end

  def format_data
  end

  def get_artist(permalink)
    response = @connection.get permalink+".json"
    response.body['artist']
  end

end