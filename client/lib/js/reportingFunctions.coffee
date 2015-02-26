#This function is used to record an attempt of the game by any user


@setGameAttempt = (gameId,userId)->
#  This function sets the individual score for the game
  console.log("game attempt");
  @attempt = individualGameAttempts.insert({userId:userId,gameId:gameId,createdAt:new Date().getTime()})
@setInitialScore =(score)->
  individualGameAttempts.update({_id:attempt},{$set:{initScore:score}})
#  This function store the last achieved score in the game
@setScore =(score)->
  individualGameAttempts.update({_id:attempt},{$set:{score:score}})

@setGameVal =(queryString,parameters) ->
  queryString = {_id:attempt}
  reports.update(queryString,{$push:{gameData:parameters}})
