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
        data.push {userid:i._id,totalScore:0,quoScores:[]}
      data.push {"userid": "gameMaster", "totalScore": 0, "quoScores": []}
      x = DDP.connect("http://127.0.0.1:4002")
      x.call('getResultOnClient',deckList,userList,(err, res)->
        if !err
          if quoScoreConfig.findOne()?
            @inputJSON = res
            @configuration = quoScoreConfig.findOne()
            @leaderboardJSON = {
                "name": "Basic Leaderboard",
                "schema": [],
                "data": data
            }
            a = generateScore("LqgDpzizcWv8KsZnD")
            finalArr = []
            for i,j in a
              finalArr.push {userid: data[j].userid, score: i}
            console.log finalArr
            tid = "LqgDpzizcWv8KsZnD"

            Meteor.call('insertAmpScore',tid, finalArr)
        else
          console.log err
      )


Template.quoleaderBoard.helpers
  leaderBoard:()->
    totalScore = []
    if ampQuoScore.findOne().results?
      for i in ampQuoScore.findOne().results
        if Meteor.users.findOne({_id:i.userid})?
          if Meteor.users.findOne({_id:i.userid}).personal_profile?
            if Meteor.users.findOne({_id:i.userid}).personal_profile.fullname?
              i.username = Meteor.users.findOne({_id:i.userid}).personal_profile.fullname
            else
              i.username = Meteor.users.findOne({_id:i.userid}).personal_profile.email
        else
          i.username=i.userid
        totalScore.push i
      totalScore
