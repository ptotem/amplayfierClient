Meteor.publish('platformData',(pname)->
  pid = platforms.findOne({tenantName:pname})._id
  [platforms.find({tenantName:pname}),deckHtml.find({platformId:pid})]
)


Meteor.publish('thisDeck',(did)->
	deckHtml.find({_id:did})
)

Meteor.publish('excelFiles',()->
	excelFiles.find({})
)
Meteor.publish('usersOfPlatform',(pname)->
	p = platforms.findOne({tenantName:pname})._id
	Meteor.users.find({platform:p})
)
Meteor.publish("loginPlatform",(tname)->
  this.ready()
  platforms.find({tenantName:tname})
)
Meteor.publish("reportsOfSlide",(pname) ->
  p = platforms.findOne({tenantName:pname})._id
  Meteor.reports.find({platform:p})
)

Meteor.publish("indexReport",() ->
  reports.find().fetch()
)