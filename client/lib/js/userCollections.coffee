@markModuleAsComplete = (deckId,userId,tenantId,completed)->
  if !isModuleComplete(deckId,userId)
    userCompletions.insert({deckId:deckId,userId:userId,createdAt:new Date().getTime(),platformId:tenantId,completed:completed})
    setComplete()


@isModuleComplete = (deckId,userId)->
  console.log userCompletions.find({deckId:deckId,userId:userId}).fetch()
  if userCompletions.find({deckId:deckId,userId:userId}).fetch().length isnt 0
    userCompletions.find({deckId:deckId,userId:userId}).fetch()[0].completed
  else
    false
