#This function is used to record an attempt of the game by any user


@setGameAttempt = (gameId,userId)->
#  This function sets the individual score for the game
  console.log("game attempt");
  # @attempt = individualGameAttempts.insert({userId:userId,gameId:gameId,createdAt:new Date().getTime()})
@setInitialScore =(score)->
  console.log("game attempt");
  # individualGameAttempts.update({_id:attempt},{$set:{initScore:score}})
#  This function store the last achieved score in the game
  # individualGameAttempts.update({_id:attempt},{$set:{score:score}})
@setScore =(score)->
  console.log("game attempt");

@setGameVal =(queryString,parameters) ->
  console.log("game attempt");
  # queryString = {_id:attempt}
  # reports.update(queryString,{$push:{gameData:parameters}})
