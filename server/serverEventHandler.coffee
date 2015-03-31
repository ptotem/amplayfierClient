
@setScore = (newVal)->
  console.log "Score is incremented"
  console.log newVal



@setCurrency = (args)->
  Meteor.users.update({_id:args[0]},{$set:{currency:args[1]}})

@deckComplete  = ()->
  console.log "deck is marked as complete on server"

@registerLogin = (args)->
  Meteor.users.update({_id:args['uid']},{$inc:{loginCount:1}})
  if Meteor.users.findOne(args['uid']).loginCount is 1
    firstLand.assign(args)

@getScore = (uid)->
  Meteor.users.findOne(uid).score
@getCurrency = (uid)->
  Meteor.users.findOne(uid).currency

@chapterComplete  = (args)->
  ""

@allChapterComplete  = (args)->
  ""


#  if args['dids']?
#    for d in args['dids']
#      console.log reports.findOne({userId:args['uid'],deckId:d})

#    console.log args
#    console.log "chapter is marked as complete on srrver"

