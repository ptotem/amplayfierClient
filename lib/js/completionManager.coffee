@markModuleAsComplete = (deckId,userId,tenantId,completed,attempt,perscore,actscore,maxscore)->

#  if !isModuleComplete(deckId,userId)
    userCompletions.insert({attempt:attempt,perscore:perscore,actscore:actscore,maxscore:maxscore,deckId:deckId,userId:userId,createdAt:new Date().getTime(),platformId:tenantId,completed:completed})




@isModuleComplete = (deckId,userId)->

  if userCompletions.find({deckId:deckId,userId:userId}).fetch().length isnt 0
    userCompletions.find({deckId:deckId,userId:userId}).fetch()[0].completed
  else
    false
