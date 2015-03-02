@markModuleAsComplete = (deckId,userId,tenantId,completed)->
  if !isModuleComplete(deckId,userId)
    userCompletions.insert({deckId:deckId,userId:userId,createdAt:new Date().getTime(),tenantId:tenantId,completed:completed})


@isModuleComplete = (deckId,userId)->
  userCompletions.find({},{deckId:deckId,userId:userId}).fetch().length isnt 0
