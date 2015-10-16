Template.quoleaderBoard.rendered = ->
  Tracker.autorun(()->
    Meteor.users.find({})
  )
  data = []
  userList = []
  if platforms.findOne()?
    deckList = platforms.findOne().quodecks
    if Meteor.users.find().fetch().length > 0
      for i in Meteor.users.find({}).fetch()
        userList.push i._id
      x = DDP.connect(Meteor.settings.public.quodeckIP)
      x.call('getResultOnClient',deckList,userList,(err, res)->
        if !err
          gameName = platforms.findOne().gameName
          @appConfiguration = setAppConfiguration(gameName);
          @inputJSON = res
          @leaderboardJSON = generateLeaderboardConfig(userList,gameName)
          for deck in deckList
            generateScore(deck)
          Meteor.call('insertAmpScore',platformName, leaderboardJSON)
        else
          console.log err
      )


Template.quoleaderBoard.helpers
  leaderBoardTotal:()->
    ls  = _.pluck(getGameParams(platforms.findOne().gameName),"name")
    results = []
    if ampQuoScore.findOne()? and ampQuoScore.findOne().results?
      for m in ls
        r = {}
        r.name = m
        totalScore = []
        if _.where(ampQuoScore.findOne().results,{name: m}).length > 0
          for i in _.where(ampQuoScore.findOne().results,{name: m})[0].data  
            if Meteor.users.findOne({_id:i.userid})?
              if Meteor.users.findOne({_id:i.userid}).personal_profile?
                i.username = Meteor.users.findOne({_id:i.userid}).personal_profile.fullname
              else
                i.username = Meteor.users.findOne({_id:i.userid}).personal_profile.email
              totalScore.push i

          r.leaderBoard = totalScore
          results.push r
      results

  mainLeaderboard:()->
    if ampQuoScore.findOne()? and ampQuoScore.findOne().results?
      gameData = getGameParams(platforms.findOne().gameName)
      basescore = _.where(gameData, {name: "Topline (Rs. Cr.)"})[0].baseSCore
      myScore = {}
      if _.where(ampQuoScore.findOne({}).results,{name: "Topline (Rs. Cr.)"}).length > 0
        scores =  _.where(ampQuoScore.findOne({}).results,{name: "Topline (Rs. Cr.)"})[0].data
        totalScore = []
        
        for i in scores
          if Meteor.users.findOne({_id:i.userid})?
            if Meteor.users.findOne({_id:i.userid}).personal_profile?
              i.username = Meteor.users.findOne({_id:i.userid}).personal_profile.fullname
            else
              i.username = Meteor.users.findOne({_id:i.userid}).personal_profile.email

          if i.totalScore? and i.totalScore < basescore
            i.score = Math.round(i.totalScore - 0.03*i.totalScore)
          else
            i.score = Math.round(i.totalScore)

          if i.userid is Meteor.userId()
            myScore = i
          if !isNaN(i.score)
            totalScore.push i
      totalScore = _.sortBy(totalScore, 'score')
      totalScore = _.map(totalScore, (val, index)->
                    val.index = index
                    val
                  )
      console.log "totalScore"
      console.log totalScore
      totalScore = totalScore.reverse()[0..4]
      totalScore.push myScore
      totalScore



