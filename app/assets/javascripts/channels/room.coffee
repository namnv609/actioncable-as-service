App.room = App.cable.subscriptions.create { channel: "RoomChannel", room: 1 },
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    $ "#messages"
      .prepend "<div class='message'><p>#{@nl2br data['message']}</p></div>"

  speak: (message) ->
    data =
      message: message
      room: 1

    @perform 'speak', data

  nl2br: (text) ->
    text.replace /\r\n|\n/, '<br />'

$ document
  .on "keypress", "[data-behavior~=room_speaker]", (e) ->
    if e.which is 13 and !e.shiftKey
      App.room.speak $(@).val()
      $(@).val ''
      e.preventDefault()
