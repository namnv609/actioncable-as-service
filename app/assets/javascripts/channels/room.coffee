App.room = App.cable.subscriptions.create channel: "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    roomID = data['room_id']
    activeRoom = $ ".chat-list .chat-item.actived"
      .data "room-id"

    if roomID is activeRoom
      $ ".chat .chat-message"
        .prepend "<div class='message'>#{@nl2br data['message']}</div>"
    else
      $unreadCountElm = $ ".chat-item[data-room-id=#{roomID}] .bubble span"
      unreadNumber = parseInt $unreadCountElm.text()
      unreadNumber++
      $unreadCountElm.text unreadNumber
        .parent().removeClass "hidden"

  speak: (message) ->
    roomID = $ ".chat-list .chat-item.actived"
      .data "room-id"
    data =
      message: message
      room: roomID

    @perform 'speak', data

  nl2br: (text) ->
    text.replace /\r\n|\n/, '<br />'

$ document
  .on "keypress", ".message-box", (e) ->
    if e.which is 13 and !e.shiftKey
      App.room.speak $(@).val()
      $(@).val ''
      e.preventDefault()

$ ->
  $ ".chat-list .chat-item"
    .on "click", ->
      $bubbleElm = $ ".bubble", $ @

      $ ".chat-list .chat-item"
        .removeClass "actived"
      $ @
        .addClass "actived"
      $ ".chat-message"
        .empty()
      $bubbleElm.addClass "hidden"
      $ "span", $bubbleElm
        .text 0
