Template.kurukshetraLeaderboardModal.events
  'click .remove-modal':(e)->
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-wrap').remove()

    $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"})

Template.kurukshetraLeaderboardModal.helpers
  mainLeaderboard:()->
    if ampQuoScore.findOne()? and ampQuoScore.findOne().results?
      teams=[{quoName:'Violet'},{quoName:'Indigo'},{quoName:'Blue'},{quoName:'Green'},{quoName:'Yellow'}]
      totalScore = []
      _.forEach(teams,(tVal, iIndex)->
        team = {}
        team.username = tVal.quoName + " Team"
        if _.where(Meteor.users.find().fetch(), {team: tVal.quoName}).length > 0
          allUsers = _.where(Meteor.users.find().fetch(),{team: tVal.quoName})
          for us in allUsers
            if _.where(ampQuoScore.findOne().results[0].data,{userid:us._id}).length > 0
              iVal = us
              if _.where(ampQuoScore.findOne().results[0].data,{userid:us._id})[0].quoScores.length > 0
                break
            else
              iVal = us
          team.score = _.where(ampQuoScore.findOne().results[0].data,{userid:iVal._id})[0].totalScore
        else
          team.score = 0

        totalScore.push team
      )
      # totalScore
      totalScore = _.sortBy(totalScore, 'score')
      totalScore = totalScore.reverse()
      totalScore = _.map(totalScore, (val, index)->
                    val.index = index + 1
                    val.classes = ""
                    val  
                  )
      console.log "totalScore"
      console.log totalScore
      totalScore

  gameMasterScore:()->
    if ampQuoScore.findOne()? and ampQuoScore.findOne().results?
      gameMasterS = {}
      if _.where(ampQuoScore.findOne().results[0].data,{userid:"gameMaster"}).length > 0
        gameMasterS = {index: "", classes: "", score:_.where(ampQuoScore.findOne().results[0].data,{userid:"gameMaster"})[0].totalScore}    
        gameMasterS
  userScore:()->
    a = getMyScore()
    a