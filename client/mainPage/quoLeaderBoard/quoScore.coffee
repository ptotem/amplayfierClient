Template.quoleaderBoard.rendered = ->
  console.log "Leader Board"
  # leaderboardLogging = true
  # logToScreen()
  # generateScore("Q1")
  # generateScore("Q2")
  # generateScore("Q3") Office/Projects/MeteorApps/NewQuoAmp/amplayfier-creator:=> amplayfier-creator
  # generateScore("Q4") Office/Projects/MeteorApps/NewQuoAmp/amplayfierClient:=>client
  # generateScore("Q5") Office/Projects/MeteorApps/Quodeck/UpdatedQuodeckCreator/quodeckCreator$:=>Creator
  # generateScore("Q6") tenantId:sJdqs6Gu7MJrQtdZy iNcZ2texjmGSmTNL2 4002
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
        # data.push {userid:i._id,totalScore:0,quoScores:[]}
      # data.push {"userid": "gameMaster", "totalScore": 0, "quoScores": []}
      x = DDP.connect("http://lvh.me:4002")
      x.call('getResultOnClient',deckList,userList,(err, res)->
        if !err
          console.log res
          @appConfiguration = setAppConfiguration();
          # console.log(appConfiguration)
          @inputJSON = res

          @leaderboardJSON = generateLeaderboardConfig(userList)

          # console.log appConfiguration
          # console.log inputJSON
          # console.log leaderboardJSON
          # console.log "sss"
          # if quoScoreConfig.findOne()?
          #   @inputJSON = res
          #   # @inputJSON[0].scores.push({"userid":"KP3A7zNnf2hYkFssA1","score":"2"})
          #   # @inputJSON[0].scores.push({"userid":"KP3A7zNnf2hYkFssA2","score":"3"})
          #   # @inputJSON[0].scores.push({"userid":"KP3A7zNnf2hYkFssA3","score":"1"})
          #   @configuration = quoScoreConfig.findOne()
          #   @leaderboardJSON = {
          #       "name": "Basic Leaderboard",
          #       "schema": [],
          #       "data": data
          #   }
          #   a = generateScore("rLmrWSMx2b7Ch3A3H")
          #   finalArr = []
          #   for i,j in a
          #     finalArr.push {userid: data[j].userid, score: i}
          #   console.log "ressssssssssssssssssssssssssssssssssss"
          #   console.log res
          #   tid = "rLmrWSMx2b7Ch3A3H"
          #   Meteor.call('insertAmpScore',tid, finalArr)
          for deck in deckList
            console.log deck
            generateScore(deck)

          Meteor.call('insertAmpScore',platformName, leaderboardJSON)


        else
          console.log err
      )


Template.quoleaderBoard.helpers
  leaderBoardTotal:()->
    
    ls = ["Market Share","Brand Penetration","Brand Equity Score", "Topline Growth", "Gross Margin", "A&P", "Net Margin"]
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



    # if ampQuoScore.findOne()? && ampQuoScore.findOne().results?
    #   for i in ampQuoScore.findOne().results
    #     if Meteor.users.findOne({_id:i.userid})?
    #       if Meteor.users.findOne({_id:i.userid}).personal_profile?
    #         if Meteor.users.findOne({_id:i.userid}).personal_profile?
    #           i.username = Meteor.users.findOne({_id:i.userid}).personal_profile.fullname
    #         else
    #           i.username = Meteor.users.findOne({_id:i.userid}).personal_profile.email
    #     else
    #       i.username=i.userid
    #     totalScore.push i
    #   totalScore
