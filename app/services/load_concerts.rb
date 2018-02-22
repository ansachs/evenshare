require 'faraday'
require 'faraday_middleware'


class LoadConcerts
  def initialize
    @connection = self.create_connection
  end

  def create_connection

    conn = Faraday.new(:url => 'http://do312.com/') do |faraday|
        faraday.use FaradayMiddleware::FollowRedirects
        faraday.request  :url_encoded
        faraday.response :json       
        faraday.adapter  Faraday.default_adapter 
      end
  end

  def concert_logic(params)

    if params['date'] == nil
      date_in_time_type = Time.now
      date_zeroed = date_in_time_type.beginning_of_day
    else
      date_in_time_type = params['date'].to_time
      date_zeroed = date_in_time_type.beginning_of_day
    end
  
    return format_data(self.get_listings(date_in_time_type.to_datetime))
  end

  def get_listings(date)
      
      format_date = date.strftime('%Y/%m/%d')
      response = @connection.get "events/#{format_date}.json"
      return response.body['events']
  end

  def format_data(concert_array)

    concert_list =[]
    concert_array.each do | event |
      
      current_concert = Concert.find_or_initialize_by(api_id: event['id'])  do |current_concert| 
        current_concert.update_attributes({title: event['title'], description: event['description'], ticket_info: event['ticket_info'], concert_date: event['begin_time'].to_datetime})
    end      

      if current_concert.save
        concert_list << current_concert
      end 

      event['artists'].each do |artist|
                
        current_band = Band.find_or_create_by(title: artist['title']) do |current_artist|
          band_info = get_band(artist['permalink'])
          begin
            current_artist.twitter = band_info['social']['twitter']['name']
          rescue
            current_artist.twitter = nil
          end
          current_artist.title = artist['title']
          current_artist.description = artist['description']
        end
                                                  
        if !current_band.save
          binding.pry
        end
        ConcertBand.find_or_create_by(concert_id: current_concert.id, band_id: current_band.id)
      end

    end
    return concert_list
  end

  def get_band(permalink)    
    response = @connection.get permalink+".json"
    response.body['artist']
  end
       

end
