# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class RoomChannel < ApplicationCable::Channel
  def subscribed
    logger.warn "PARAMS: #{params}"
    stream_from "room_channel_#{params['room'].to_i}_message"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast "room_channel_#{data['room'].to_i}_message", message: data['message']
  end
end
