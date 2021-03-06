@firstLand = new Badge('firstTimeLandMedal','Well Started','Badge Description','/assets/badgeimages/wellstarted.png',[score])
firstLand.on('assign',(t,args)->

  oldcurrency = currency.getValue(args['uid'])
  newcurrency = oldcurrency + parseInt(_.where(platforms.findOne(args['pid']).badges,{name:'firstTimeLandMedal'})[0].value)
  currency.setValue(newcurrency,Meteor.userId())
  Meteor.users.update({_id:Meteor.userId()},{$addToSet:{badges:t}})
  createUserNotification(args['uid'],args['pid'],"You have won the Well Started badge")

)

#
#firstLand.on('deckComplete',(t)->
#  console.log "deck cokete"
#)



@chapterCompletion = new Badge("chapterCompleteMedal","Milestone",'Badge Description','/assets/badgeimages/milestone.png',[score,currency])
chapterCompletion.on('chapterComplete',(t,args)->

  if userNodeStatus.findOne({userId:args['uid'],nodeSeq:args['node']})?
    console.log "sungle node completion medal"

    oldcurrency = currency.getValue(args['uid'])
    newcurrency = oldcurrency + parseInt(_.where(platforms.findOne(args['pid']).badges,{name:'chapterCompleteMedal'})[0].value)
    currency.setValue(newcurrency,args['uid'])
    Meteor.users.update({_id:args['uid']},{$addToSet:{badges:t}})
    userNodeStatus.remove({userId:args['uid'],nodeSeq:args['node']})
    createUserNotification(args['uid'],args['pid'],"You have won the Milestone badge")
)


@allNodeComplete = new Badge("allNodeComplete","All Done",'Badge Description','/assets/badgeimages/alldone.png',[score,currency])
allNodeComplete.on('allchapterComplete',(t,args)->

  oldcurrency = currency.getValue(args['uid'])
  newcurrency = oldcurrency + parseInt(_.where(platforms.findOne(args['pid']).badges,{name:'allNodeComplete'})[0].value)
  currency.setValue(newcurrency,args['uid'])
  Meteor.users.update({_id:args['uid']},{$addToSet:{badges:t}})
  createUserNotification(args['uid'],args['pid'],"You have won the All Done badge")

)


@fullScoreInNode = new Badge("fullScoreInDecks","Through Decks",'Badge Description','/assets/badgeimages/thorough.png',[score,currency])
fullScoreInNode.on('chapterComplete',(t,args)->

  if args['status']
    oldcurrency = currency.getValue(args['uid'])
    newcurrency = oldcurrency + parseInt(_.where(platforms.findOne(args['pid']).badges,{name:'fullScoreInDecks'})[0].value)
    currency.setValue(newcurrency,args['uid'])
    Meteor.users.update({_id:args['uid']},{$addToSet:{badges:t}})
    createUserNotification(args['uid'],args['pid'],"You have won the All Through decks badge")

)


#@allChapterCompletion = new Badge("allChapterCompleteMedal",'Badge Description','/assets/badgeimages/alldone.png',[score,currency])
#allChapterCompletion.on('assign',(t)->
#
#  oldcurrency = currency.getValue()
#  newcurrency = oldcurrency + 100
#  currency.setValue(newcurrency)
#  Meteor.users.update({_id:Meteor.userId()},{$addToSet:{badges:t}})
#  flag = true
#  for n in platformData.nodes
#    if n.decks?
#      for d in n.decks
#        #      console.log n
#        slideRep = _.groupBy(reports.find({userId:Meteor.userId(),deckId:d}).fetch(),(x)->
#          x.slideId
#        )
#        if _.isEmpty(slideRep)
#          flag = false
#        for k in Object.keys(slideRep)
##          console.log "---------------"
##          console.log slideRep[k]
##          console.log  _.compact(_.pluck(slideRep[k],'scorePercentage'))
#          if  _.compact(_.pluck(slideRep[k],'scorePercentage')).indexOf(100) is -1
#            flag = false
#  #  console.log flag
#  if flag
#    allThroughDecks.assign()
#
#
#
#
#
#
##    reports.find({userId:Meteor.userId,})
#
#)
