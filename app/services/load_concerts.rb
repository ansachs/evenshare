require 'faraday'
require 'faraday_middleware'


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
    if params['date'] == nil
      date_in_time_type = Time.now
      date_zeroed = date_in_time_type.beginning_of_day
    else
      date_in_time_type = params['date'].to_time
      date_zeroed = date_in_time_type.beginning_of_day
    end
    # the purpose of this logic was to reduce API calls
    if Concert.where(concert_date: ((date_zeroed).to_datetime..(date_in_time_type + 24.hours).to_datetime)).exists?
      return Concert.where(concert_date: ((date_zeroed).to_datetime..(date_in_time_type + 24.hours).to_datetime))
    else 
      return format_data(self.get_listings(date_in_time_type.to_datetime))
    end
  end

  def get_listings(date)
      
      format_date = date.strftime('%Y/%m/%d')
      # binding.pry
      response = @connection.get "events/#{format_date}.json"
      return response.body['events']
  end

  def format_data(concert_array)
    concert_list =[]
    concert_array.each do | event |

        event['artists'].each do |artist|
          if Band.where(title: artist['title']) == nil
            band_info = get_band(artist['permalink'])
            save_band(band_info['artist'])
          end
        end
        concert_list << Concert.create_with(title: event['title'], description: event['description'], ticket_info: event['ticket_info'], concert_date: event['begin_time'].to_datetime).find_or_create_by(api_id: event['id'])  
    end
    return concert_list
  end

  def get_band(permalink)
    response = @connection.get permalink+".json"
    response.body['artist']
  end

  def save_band(artist)
    Band.create(title: artist['title'], description: artist['description'], twitter: [artist['social']['twitter']]  )
  end

end