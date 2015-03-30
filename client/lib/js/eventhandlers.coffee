@registerLogin = ()->
  userActivity.insert({entityId:Meteor.userId(),entityType:'user',message:Meteor.user().personal_profile.display_name+" logged in at "+new Date().getTime(),createdAt:new Date().getTime()})
@registerLogout = ()->
  userActivity.insert({entityId:Meteor.userId(),entityType:'user',message:Meteor.user().personal_profile.display_name+" logged out at "+new Date().getTime(),createdAt:new Date().getTime()})
@landOnWrapper = ()->
  userActivity.insert({entityId:Meteor.userId(),entityType:'user',message:Meteor.user().personal_profile.display_name+" opened story wrapper at "+new Date().getTime(),createdAt:new Date().getTime()})
@newUser = ()->
  userActivity.insert({entityId:Meteor.userId(),entityType:'user',message:Meteor.user().personal_profile.display_name+" created a new user at "+new Date().getTime(),createdAt:new Date().getTime()})

@nodeOpen = ()->
  userActivity.insert({entityId:Meteor.userId(),entityType:'node',message:Meteor.user().personal_profile.display_name+" open node at "+new Date().getTime(),createdAt:new Date().getTime()})
  nodeOpenMedal.assign()

@deckOpen = ()->
  userActivity.insert({entityId:Meteor.userId(),entityType:'deck',message:Meteor.user().personal_profile.display_name+" open deck at "+new Date().getTime(),createdAt:new Date().getTime()})
  nodeOpenMedal.assign()
@getScore = ()->
  Meteor.user().score
@getCurrency = ()->
  console.log "curren"
  Meteor.user().currency
