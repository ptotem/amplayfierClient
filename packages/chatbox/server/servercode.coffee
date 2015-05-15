
if Meteor.isServer
  Meteor.methods
    sendMessage: (from, to, message) ->
      a = Meteor.users.findOne({_id: to} )
      if a.chatModal is true
        console.log("777")
        messages.insert({from: from, to: to, message: message, time: new Date().getTime(), unread: false } )
      else
        console.log("888")
        messages.insert({from: from, to: to, message: message, time: new Date().getTime(), unread: true } )

    markReadMessage: (from, to) ->
      messages.update({from: from, to: to, unread: true} , {$set: {unread: false} } , {multi: true} )

    createChatSettings: (userId, settings, favs) ->
      chatSettings.insert({userId: userId, settings: settings, favs : favs } )

    updateUserChatTrue: (userId) ->
      Meteor.users.update({_id: userId} , {$set: {chatModal: true} } )

    updateUserChatFalse: (userId) ->
      Meteor.users.update({_id: userId} , {$set: {chatModal: false} } )


  Meteor.publish('userStatus', () ->
    this.ready()
    Meteor.users.find({ "status.online": true } )
  )

  Meteor.publish('messages', () ->
    this.ready()
    messages.find({} )
  )

  Meteor.publish('chatSettings', (userId) ->
    this.ready()
    chatSettings.find({userId: userId} )
  )

  # Meteor.publish('unreadMessages', (userId) ->
  #   this.ready()
  #   messages.find({to: userId, unread: true} )
  # )
