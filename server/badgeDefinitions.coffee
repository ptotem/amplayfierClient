@firstLand = new Badge('firstTimeLandModal','/assets/badgeimages/wellstarted.png',[score])
firstLand.on('assign',(t)->
  oldcurrency = currency.getValue()
  newcurrency = oldcurrency + 100
  currency.setValue(newcurrency)
  Meteor.users.update({_id:Meteor.userId()},{$addToSet:{badges:t}})
)


firstLand.on('deckComplete',(t)->
  console.log "deck cokete"
)
@chapterCompletion = new Badge("chapterCompleteMedal",'/assets/badgeimages/milestone.png',[score,currency])
chapterCompletion.on('assign',(t)->
  oldcurrency = currency.getValue()
  newcurrency = oldcurrency + 50
  currency.setValue(newcurrency)
  Meteor.users.update({_id:Meteor.userId()},{$addToSet:{badges:t}})
)


@allThroughDecks = new Badge("allDeckFullScoreMedal",'/assets/badgeimages/through.png',[score,currency])
allThroughDecks.on('assign',(t)->
#  console.log "all through assigned"
  oldcurrency = currency.getValue()
  newcurrency = oldcurrency + 200
  currency.setValue(newcurrency)
  Meteor.users.update({_id:Meteor.userId()},{$addToSet:{badges:t}})
)




@allChapterCompletion = new Badge("allChapterCompleteMedal",'/assets/badgeimages/alldone.png',[score,currency])
allChapterCompletion.on('assign',(t)->

  oldcurrency = currency.getValue()
  newcurrency = oldcurrency + 100
  currency.setValue(newcurrency)
  Meteor.users.update({_id:Meteor.userId()},{$addToSet:{badges:t}})
  flag = true
  for n in platformData.nodes
    if n.decks?
      for d in n.decks
        #      console.log n
        slideRep = _.groupBy(reports.find({userId:Meteor.userId(),deckId:d}).fetch(),(x)->
          x.slideId
        )
        if _.isEmpty(slideRep)
          flag = false
        for k in Object.keys(slideRep)
#          console.log "---------------"
#          console.log slideRep[k]
#          console.log  _.compact(_.pluck(slideRep[k],'scorePercentage'))
          if  _.compact(_.pluck(slideRep[k],'scorePercentage')).indexOf(100) is -1
            flag = false
  #  console.log flag
  if flag
    allThroughDecks.assign()






#    reports.find({userId:Meteor.userId,})

)
