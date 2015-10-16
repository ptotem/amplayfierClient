#---------------------------------------- Company Health Leader ---------------------------------------


Template.kurukshetraHealthModal.rendered = ->
  # Tracker.autorun(()->
  #   Meteor.users.find({})
  # )
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


Template.kurukshetraHealthModal.helpers
  leaderBoard:()->
    # results = []
    teams=[{quoName:'Violet'},{quoName:'Indigo'},{quoName:'Blue'},{quoName:'Green'},{quoName:'Yellow'},{quoName:'Orange'},{quoName:'Red'}]
    # if 
    # if ampQuoScore.findOne()? and platforms.findOne()?
    #   for i,q in platforms.findOne().quodecks
    #     a = {}
    #     a.quoid = i
    #     a.quoName = teams[q]
    #     a.parameters = []
    #     _.forEach(ampQuoScore.findOne().results, (result, index)->
    #       c = {}
    #       c.name = result.name
    #       ind = _.indexOf(result.schema, i)
    #       if _.where(result.data, {userid: Meteor.userId()}).length > 0
    #         # console.log "In -------" + Meteor.userId()
    #         console.log _.where(result.data, {userid: Meteor.userId()})
    #         if _.where(result.data, {userid: Meteor.userId()})[0].quoScores.length > ind
    #           score = Math.round(_.where(result.data, {userid: Meteor.userId()})[0].quoScores[ind])
    #         else  
    #           score = 0
    #       else
    #         score = 0
    #       c.score = score
    #       a.parameters.push c
    #     )
    #     results.push a
    #   console.log results
    #   results
    teams

  leaderBoard1:()->
    results = []
    # if ampQuoScore.findOne()? and platforms.findOne()?
    #   baseConfig = getGameParams(platforms.findOne().gameName)
    #   _.forEach(ampQuoScore.findOne().results, (result, index)->
    #     a= {}
    #     a.name = result.name
    #     b = []
    #     a.data = [{score:_.where(baseConfig, {name: result.name})[0].baseSCore}]
    #     _.forEach(platforms.findOne().quodecks, (quo, innerIndex)->
    #       c = {}
    #       ind = _.indexOf(result.schema, quo)
    #       if _.where(result.data, {userid: Meteor.userId()})[0].quoScores.length > ind
    #         score = Math.round(_.where(result.data, {userid: Meteor.userId()})[0].quoScores[ind])
          
    #       else  
    #         score = 0

    #       # console.log "Prev score : " + a.data[innerIndex-1].score + " | This score : " +score
    #       c.score = score
    #       if innerIndex > 0 and a.data[innerIndex-1].score > score
    #         cls = "fa-arrow-down text-danger"
    #       else
    #         cls = "fa-arrow-up text-success"
    #       c.classes = cls
    #       a.data.push c

    #     )
        
    #     results.push a
    #   )
    #   results
    if ampQuoScore.findOne()? and platforms.findOne()?
      baseConfig = getGameParams(platforms.findOne().gameName)
      _.forEach(platforms.findOne().quodecks, (val, index)->
        a = {}
        a.name = "Round "+ (index+1)
        a.data = [{score: getGameMasterData().quoScores[index]}]
        _.forEach(Meteor.users.find().fetch(),(iVal, iIndex)->
          if _.where(ampQuoScore.findOne().results[0].data,{userid:iVal._id}).length > 0
            console.log _.where(ampQuoScore.findOne().results[0].data,{userid:iVal._id})
            da =  _.where(ampQuoScore.findOne().results[0].data,{userid:iVal._id})[0]
            a.data.push {score: da.quoScores[index]}
          else
            a.data.push {score: 0}
        )
        results.push a
      )
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