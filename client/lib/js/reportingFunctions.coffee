#This function is used to record an attempt of the game by any user


@startAttempt = ()->
#  This function sets the individual score for the game
  gameId = ""
  userId = Meteor.userId()
  console.log("game attempt");
  @attempt = reports.insert({userId:userId,gameId:gameId,createdAt:new Date().getTime()})


@setInitialScore =(score)->
  reports.update({_id:attempt},{$set:{initScore:score}})
#  This function store the last achieved score in the game


@setScore =(score)->
  reports.update({_id:attempt},{$set:{score:score}})

@setGameVal =(parameters) ->
  queryString = {_id:attempt}
  reports.update(queryString,{$push:{gameData:parameters}})

@setMetaData = (objectParameter) ->
  gameId = ""
  reportMeta.insert({ gameId: gameId, keyRecords: objectParameter})
  console.log "Setting up meta data of the game....."

@setComplete = ()->
  queryString = {_id:attempt}
  reports.update(queryString,{$set:{completed: true}})

@setTime = (timeTaken)->
  queryString = {_id: attempt}
  reports.update(queryString,{$set:{time:timeTaken}})
