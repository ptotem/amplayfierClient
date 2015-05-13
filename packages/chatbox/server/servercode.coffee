
if Meteor.isServer
  Meteor.methods
    sendMessage: (from, to, message) ->
      messages.insert({from: from, to: to, message: message, time: new Date().getTime() } )

    createChatSettings: (userId, settings, favs) ->
      chatSettings.insert({userId: userId, settings: settings, favs : favs } )

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
