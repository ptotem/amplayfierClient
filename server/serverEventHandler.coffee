
@setScore = (newVal)->
  console.log "Score is incremented"
  console.log newVal



@setCurrency = (args)->
  Meteor.users.update({_id:args[0]},{$set:{currency:args[1]}})

