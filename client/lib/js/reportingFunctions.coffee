#This function is used to record an attempt of the game by any user


@startAttempt = (gameId,userId)->
#  This function sets the individual score for the game
  console.log("game attempt");
  @attempt = reports.insert({userId:userId,gameId:gameId,createdAt:new Date().getTime()})


@setInitialScore =(score)->
  reports.update({_id:attempt},{$set:{initScore:score}})
#  This function store the last achieved score in the game


@setScore =(score)->
  reports.update({_id:attempt},{$set:{score:score}})

@setGameVal =(queryString,parameters) ->
  queryString = {_id:attempt}
  reports.update(queryString,{$push:{gameData:parameters}})

@initMetaData = (gameId, objectParameter) ->
  reportMeta.insert({ gameId: gameId, keyRecords: objectParameter})

@setComplete = ()->
  queryString = {_id:attempt}
  reports.update(queryString,{$set:{completed: true}})

@setTime = (timeTaken)->
  queryString = {_id: attempt}
  reports.update(queryString,{$set:{time:timeTaken}})
