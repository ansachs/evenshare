class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # binding.pry
    stream_from "room"
  end

  # def unsubscribed
  #   # Any cleanup needed when channel is unsubscribed
  # end

  # def speak(data)
  #   Chat.create!(statement: data['message'], user_id: 1, concert_id: 1)
  # end
end
