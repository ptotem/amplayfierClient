#Meteor.publish('temps',()->
#	[platforms.find({}),deckHtml.find({})]
#)

Meteor.publish('platformData', (pname)->
  if platforms.findOne({tenantName: pname})?
    this.ready()
    pid = platforms.findOne({tenantName: pname})._id
    tid = platforms.findOne({tenantName: pname}).tenantId
    console.log pid
    [platforms.find({tenantName: pname}), deckHtml.find({platformId: pid}),userCompletions.find({tenantId:tid})]
  else
    []
)


Meteor.publish('thisDeck', (did)->
  this.ready()
  deckHtml.find({_id: did})
)

Meteor.publish('excelFiles', ()->
  this.ready()
  excelFiles.find({})
)
Meteor.publish('usersOfPlatform', (pname)->
  this.ready()
  p = platforms.findOne({tenantName: pname})._id
  Meteor.users.find({platform: p})
)
Meteor.publish("loginPlatform", (tname)->
  this.ready()
  console.log tname
  platforms.find({tenantName: tname})
)
Meteor.publish("reportsOfSlide", (pname) ->
  this.ready()
  p = platforms.findOne({tenantName: pname})._id
  Meteor.reports.find({platform: p})
)

Meteor.publish("indexReport", () ->
  this.ready()
  reports.find({})
)

Meteor.publish('thisJs', ()->
  this.ready()
  deckJs.find({})
)

Meteor.publish('allUsers',(pname)->
  this.ready()
  console.log "-----------------------"
  console.log Meteor.users.find({})
  Meteor.users.find({})
)

Meteor.publish("thisUser",(uid)->
  this.ready()
  tid = Meteor.users.find({_id:uid},{fields:{personal_profile:1,services:1,role:1,profile:1}})
)


Meteor.publish('gameQuestionbank',()->
  this.ready()
  gameData.find({})
)

Meteor.publish('customizationDecks',()->
  this.ready()
  customizationDecks.find({})
)
