class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # binding.pry
    stream_from "room_#{params['room']}"
  end

  def unsubscribed
    stop_all_streams
  end


  # def speak(data)
  #   Chat.create!(statement: data['message'], user_id: 1, concert_id: 1)
  # end

  
end
