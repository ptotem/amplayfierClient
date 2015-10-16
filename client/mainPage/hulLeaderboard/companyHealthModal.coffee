#---------------------------------------- Company Health Leader ---------------------------------------


Template.companyHealthModal.rendered = ->
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


Template.companyHealthModal.helpers
  leaderBoard:()->
    results = []
    if ampQuoScore.findOne()? and platforms.findOne()?
      for i,q in platforms.findOne().quodecks
        a = {}
        a.quoid = i
        a.quoName = 2005 + (q+1)
        a.parameters = []
        _.forEach(ampQuoScore.findOne().results, (result, index)->
          c = {}
          c.name = result.name
          ind = _.indexOf(result.schema, i)
          if _.where(result.data, {userid: Meteor.userId()}).length > 0
            # console.log "In -------" + Meteor.userId()
            console.log _.where(result.data, {userid: Meteor.userId()})
            if _.where(result.data, {userid: Meteor.userId()})[0].quoScores.length > ind
              score = Math.round(_.where(result.data, {userid: Meteor.userId()})[0].quoScores[ind])
            else  
              score = 0
          else
            score = 0
          c.score = score
          a.parameters.push c
        )
        results.push a
      console.log results
      results

  leaderBoard1:()->
    results = []
    if ampQuoScore.findOne()? and platforms.findOne()?
      baseConfig = getGameParams(platforms.findOne().gameName)
      _.forEach(ampQuoScore.findOne().results, (result, index)->
        a= {}
        a.name = result.name
        b = []
        a.data = [{score:_.where(baseConfig, {name: result.name})[0].baseSCore}]
        _.forEach(platforms.findOne().quodecks, (quo, innerIndex)->
          c = {}
          ind = _.indexOf(result.schema, quo)
          if _.where(result.data, {userid: Meteor.userId()})[0].quoScores.length > ind
            score = Math.round(_.where(result.data, {userid: Meteor.userId()})[0].quoScores[ind])
          
          else  
            score = 0

          # console.log "Prev score : " + a.data[innerIndex-1].score + " | This score : " +score
          c.score = score
          if innerIndex > 0 and a.data[innerIndex-1].score > score
            cls = "fa-arrow-down text-danger"
          else
            cls = "fa-arrow-up text-success"
          c.classes = cls
          a.data.push c

        )
        
        results.push a
      )
      results

  getGameParams:()->
    if platforms.findOne()?
      getGameParams(platforms.findOne().gameName)


Template.companyHealthModal.events
  'click .remove-modal':(e)->
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-wrap').remove()

    $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"})
