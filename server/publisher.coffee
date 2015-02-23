Meteor.publish('platformData',(pname)->
  pid = platforms.findOne({tenantName:pname})._id
  [platforms.find({tenantName:pname}),deckHtml.find({platformId:pid})]
)


Meteor.publish('thisDeck',(did)->
	deckHtml.find({_id:did})
)


