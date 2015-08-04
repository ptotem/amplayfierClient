#This function is used to record an attempt of the game by any user


@startAttempt = (expectedLength)->
  console.log "start attempt caled"
  console.log expectedLength
#  This function sets the individual score for the game
  blob = {}
#  blob.userId = Meteor.userId()
#  blob.slideId = currentTemplateId
#  blob.deckId = currentDeckId
#
#  if currentSlideType
#    blob.gameId = currentGameId
#    blob.slideType = "game"
#  else
#    blob.slideType = "slide"
#    blob.panelId = currentPanelId
#    blob.variantName = currentVariant

  blob.createdAt = new Date().getTime()
  blob.deckComplete = false
  blob.slideCount = expectedLength
  blob.userId = Meteor.userId()
  if currentDeckId?
    blob.deckId = currentDeckId
  else
    blob.deckId = "-1"
  # blob.deckId = "currentDeckId"
  blob.platformId = platforms.findOne()._id
  Session.set("currentSlideScore",0)
  @attempt = reports.insert(blob)


@endAttempt = ()->
  if reports.findOne(attempt).slideData.length >= reports.findOne(attempt).slideCount
    reports.update({_id:attempt},{$set:{attemptComplete:true}})


@setInitialScore =(score)->
  reports.update({_id:attempt},{$set:{initScore:score}})
#  This function store the last achieved score in the game


@setScore =(score,gameName)->

  # points = gameMaxPoints*score/100
  points = score/100
  console.log "score " + gameName
  if currentIntegratedGameId?
    gameIdIntegrated = currentIntegratedGameId
  else
    gameIdIntegrated = -1


  if gameMaxPoints?
    maxPoints = gameMaxPoints
  else
    maxPoints = -1

  reports.update({_id:attempt},{$push:{slideData:{gameName:gameName,slideId:-1,panelId:gameIdIntegrated,slideScore:points,slideTime:-1,slideMaxTime:-1,slideMinTime:-1,slidePoints:maxPoints,percentageScore:score}}})
#  reports.update({_id:attempt},{$set:{score:score, updatedAt:new Date().getTime()}})
#  Meteor.call('addUserScore',Meteor.userId(),score)

@setGameVal =(parameters) ->

  queryString = {_id:attempt}

  parameters.createdAt = new Date().getTime()
  parameters['attempt'] = attempt
  if currentIntegratedGameId?
    parameters['gameId']= currentIntegratedGameId
  else
    parameters['gameId']= -1

  parameters['userId'] = Meteor.userId()
  parameters['platformId'] = platforms.findOne()._id
#  reports.update({_id:attempt},{$push:{slideData:{slideId:currentTemplateId,panelId:currentPanelId,slideScore:score,slideTime:slideTime,slideMaxTime:maxTime,slideMinTime:minTime,slidePoints:points,percentageScore:scorePercentage}}})
#  Session.set("currentSlideScore", 0)
#  true
#  reports.update({_id:attempt},{$push:{slideData:{slideId:-1,panelId:currentIntegratedGameId,slideScore:score,slideTime:slideTime,slideMaxTime:maxTime,slideMinTime:minTime,slidePoints:points,percentageScore:scorePercentage}}})
  gameValData.insert(parameters)

@setMetaData = (objectParameter) ->
  if currentGameId?
    gameId = currentGameId
    reportMeta.insert({ gameId: gameId, createdAt: new Date().getTime(), keyRecords: objectParameter})


@setComplete = ()->
  queryString = {_id:attempt}
  reports.update(queryString,{$set:{completed: true, updatedAt:new Date().getTime()}})

@setTime = (timeTaken)->
  console.log "time being set"
  console.log timeTaken
  queryString = {_id: attempt}
  reports.update(queryString,{$set:{completed:true,time:timeTaken, updatedAt:new Date().getTime()}})

@getTime = ()->
  time = new Date().getTime()
  diff = time - Session.get("startTime")
  Session.set("startTime",0)
  diff

@startTime = ()->
  console.log "time staet"
  Session.set("startTime",new Date().getTime())

@setPanelReport = (panelId, points)->
  panelReport.create({slideId: currentTemplateId, userId : Meteor.userId(), panelId: panelId, points: points, createdAt: new Date().getTime()})
