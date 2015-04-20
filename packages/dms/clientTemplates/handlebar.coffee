if Meteor.isClient
  UI.registerHelper 'getUrl',(id)->
    window[Session.get('collUsed')].findOne(id).url()