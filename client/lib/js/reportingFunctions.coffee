#This function is used to record an attempt of the game by any user


@startAttempt = ()->
  console.log "startAttempt"
#  This function sets the individual score for the game
  blob = {}
  blob.userId = Meteor.userId()
  blob.slideId = currentTemplateId

  blob.deckId = currentDeckId
  if currentSlideType == true
    blob.gameId = currentGameId
    blob.slideType = "game"
  else
    blob.slideType = "slide"
    blob.panelId = currentPanelId
    blob.variantName = currentVariant

  blob.createdAt = new Date().getTime()
  Session.set("currentSlideScore",0)
  @attempt = reports.insert(blob)


@setInitialScore =(score)->
  reports.update({_id:attempt},{$set:{initScore:score}})
#  This function store the last achieved score in the game


@setScore =(score)->
  reports.update({_id:attempt},{$set:{score:score, updatedAt:new Date().getTime()}})

@setGameVal =(parameters) ->
  queryString = {_id:attempt}
  parameters.createdAt = new Date().getTime()
  reports.update(queryString,{$push:{gameData:parameters}, $set:{updatedAt:new Date().getTime()}})

@setMetaData = (objectParameter) ->
  if currentGameId?
    gameId = currentGameId
    reportMeta.insert({ gameId: gameId, createdAt: new Date().getTime(), keyRecords: objectParameter})
    console.log "Setting up meta data of the game....."

@setComplete = ()->
  queryString = {_id:attempt}
  reports.update(queryString,{$set:{completed: true, updatedAt:new Date().getTime()}})

@setTime = (timeTaken)->
  queryString = {_id: attempt}
  reports.update(queryString,{$set:{time:timeTaken, updatedAt:new Date().getTime()}})

@getTime = ()->
  time = new Date().getTime()
  diff = time - Session.get("startTime")
  Session.set("startTime",0)
  diff

@startTime = ()->
  Session.set("startTime",new Date().getTime())

@setPanelReport = (panelId, points)->
  panelReport.create({slideId: currentTemplateId, userId : Meteor.userId(), panelId: panelId, points: points, createdAt: new Date().getTime()})
