#---------------------------------------- Company Health Leader ---------------------------------------


Template.kurukshetraHealthModal.rendered = ->
  # Tracker.autorun(()->
  #   Meteor.users.find({})
  # )
  data = []
  userList = []
  result = []
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
          returnData = _.map(_.groupBy(res,'quoid'),(val,key)->
            sortedResult = {}
            da = _.where(_.flatten(_.pluck(val, "scores")))
            so = _.sortBy(da, 'updatedTime')
            un = _.uniq so.reverse(), (p) ->
                p.team
            sortedResult.quoid = key
            sortedResult.scores = un
            sortedResult
          )
          
          setInputJson(returnData)
          @leaderboardJSON = generateLeaderboardConfig(userList,gameName)
          
          for deck in deckList
            generateScore(deck)
          Meteor.call('insertAmpScore',platformName, leaderboardJSON)
        else
          console.log err
      )


Template.kurukshetraHealthModal.helpers
  leaderBoard:()->
    teams=[{quoName:'Blue'},{quoName:'Green'},{quoName:'Indigo'},{quoName:'Orange'},{quoName:'Red'},{quoName:'Violet'},{quoName:'Yellow'},{quoName:"Krishna"}]
    teams

  leaderBoard1:()->
    results = []
    #I hate doing this but this cruel world ..............
    teams=[{quoName:'Blue'},{quoName:'Green'},{quoName:'Indigo'},{quoName:'Orange'},{quoName:'Red'},{quoName:'Violet'},{quoName:'Yellow'}]
    if ampQuoScore.findOne()? and platforms.findOne()?
      users = getUserOfTeam();
      baseConfig = getGameParams(platforms.findOne().gameName)
      _.forEach(platforms.findOne().quodecks, (val, index)->
        a = {}
        a.name = "Round "+ (index+1)
        score = if getGameMasterData().quoScores[index] > 0 then "Active" else "Defeated"
        a.data = [{score: score}]
        _.forEach(teams,(tVal, iIndex)->
          if _.where(Meteor.users.find().fetch(), {team: tVal.quoName}).length > 0
            allUsers = _.where(Meteor.users.find().fetch(),{team: tVal.quoName})
            for us in allUsers
              if _.where(ampQuoScore.findOne().results[0].data,{userid:us._id}).length > 0
                iVal = us
                if _.where(ampQuoScore.findOne().results[0].data,{userid:us._id})[0].quoScores.length > 0
                  break
              else
                iVal = us
            if _.where(ampQuoScore.findOne().results[0].data,{userid:iVal._id}).length > 0
              da =  _.where(ampQuoScore.findOne().results[0].data,{userid:iVal._id})[0]
              a.data.push {score: da.quoScores[index]}
            else
              a.data.push {score: 0}


          else
            a.data.push {score: 0}
        )
        a.data.push({score: getGameMasterData().quoScores[index]})
        results.push a
      )
      console.log getInputJson()
      results

  getGameParams:()->
    if platforms.findOne()?
      getGameParams(platforms.findOne().gameName)


Template.kurukshetraHealthModal.events
  'click .remove-modal':(e)->
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-wrap').remove()

    $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"})

@getGameMasterData = ()->
  if ampQuoScore.findOne()?
    aq = ampQuoScore.findOne().results[0].data
    ms = _.where(aq, {userid:"gameMaster"})[0]
    ms

@getUserOfTeam = ()->
  users=[]
  users = _.sortBy(_.compact(_.map(_.groupBy(Meteor.users.find().fetch(), 'team'), (val, index) ->
      if index isnt "undefined" and index isnt "Choose your team"
        return val[0]
    )),'team')
  users

@setInputJson = (ipJson) ->
  @inputJSON = ipJson

@getInputJson = ()->
  @inputJSON
