# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def subscribed
    (1..3).step(1) do |room_id|
      stream_from "room_channel_#{room_id}_message"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast "room_channel_#{data['room'].to_i}_message", {
      message: data['message'],
      room_id: data['room']
    }
  end
end
