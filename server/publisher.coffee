#Meteor.publish('temps',()->
#	[platforms.find({}),deckHtml.find({})]
#)
#
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

Meteor.publish('platformWrapperData', (pname)->
  if platforms.findOne({tenantName: pname})?
    this.ready()
    pid = platforms.findOne({tenantName: pname, isMaster: true})._id
    tid = platforms.findOne({tenantName: pname, isMaster: true}).tenantId
    console.log pid
    [platforms.find({tenantName: pname, isMaster: true}), deckHtml.find({platformId: pid}),userCompletions.find({tenantId:tid})]
  else
    []
)

Meteor.publish('subPlatformWrapperData', (pname, spid)->
  if platforms.findOne({tenantName: pname})?
    this.ready()
    pid = platforms.findOne({tenantName: pname, tenantId: spid, isMaster: false})._id
    tid = platforms.findOne({tenantName: pname, isMaster: true}).tenantId
    console.log "PID : " + pid
    [platforms.find({tenantName: pname, isMaster: false, tenantId: spid}), deckHtml.find({platformId: pid}),userCompletions.find({tenantId:tid})]
  else
    []
)

Meteor.publish('thisDeck', (did)->
  this.ready()
  deckHtml.find({_id: did})
)

Meteor.publish('thisAssessment', (aid)->
  this.ready()
  assesments.find({_id: aid})
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
  tid = Meteor.users.find({_id:uid},{fields:{personal_profile:1,services:1,role:1,profile:1,badges:1,unreadNoti:1,currency:1,score:1}})
)
Meteor.publish("platformRewards",(pname)->
  this.ready()

  p = platforms.findOne({tenantName: pname})._id
  systemRewards.find({pid:p})
)


Meteor.publish('gameQuestionbank',(pname)->
  this.ready()
  pid = platforms.findOne({tenantName: pname})._id
  gameData.find({platformId:pid})
)

Meteor.publish('customizationDecks',()->
  this.ready()
  customizationDecks.find({})
)
Meteor.publish('plaformUserFeedbacks',(pname)->
  this.ready()
  pid = platforms.findOne({tenantName: pname})._id
  plaformUserFeedbacks.find({platformId:pid})
)


Meteor.publish('panelReport',()->
  this.ready()
  panelReport.find({})
)
Meteor.publish('repositoryFiles',(pname)->
  this.ready()

  pid = platforms.findOne({tenantName: pname})._id
  repositoryFiles.find({platform:pid})
)

Meteor.publish('userCompletions',(pname,uid)->
  this.ready()

  pid = platforms.findOne({tenantName: pname})._id
  console.log "My platform Id : " + pid
  [userCompletions.find({platformId:pid,userId:uid}),userNodeCompletions.find({userId:uid})]
)

Meteor.publish('userCompletionsOnGame',(tid,uid)->
  this.ready()

  pid = platforms.findOne({tenantId: tid})._id
  [userCompletions.find({platformId:pid,userId:uid}),userNodeCompletions.find({userId:uid})]
)

Meteor.publish('userAssetFiles',(uid)->
  this.ready()


  assetFiles.find({owner:uid})
)

Meteor.publish('platformAssetFiles',(pname)->
  this.ready()
  pid = platforms.findOne({tenantName: pname})._id

  assetFiles.find({platform:pid})
)

Meteor.publish('scoreQuestions',(pname)->
  this.ready()
  pid = platforms.findOne({tenantName: pname})._id

  scoreQuestions.find({platform:pid})
)

Meteor.publish('assesments',(pname)->
  this.ready()
  pid = platforms.findOne({tenantName: pname})._id

  assesments.find({platform:pid})
)

Meteor.publish('assesmentScore',(pname)->
  this.ready()
  pid = platforms.findOne({tenantName: pname})._id

  assesmentScore.find({})
)
Meteor.publish('badges',()->
  this.ready()


  systemBadges.find({})
)


Meteor.publish('subGameQuestions',(spid)->
  this.ready()

  # pid = platforms.findOne({tenantName: pname}).tenantId
  gameData.find({tenantId:spid})
)
