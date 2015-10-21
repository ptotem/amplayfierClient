#---------------------------------------- Company Health Leader ---------------------------------------


Template.kurukshetraHealthModal.rendered = ->
  # Tracker.autorun(()->
  #   Meteor.users.find({})
  # )
  $('.shity-tabs li:nth-child(1) a').click()
  data = []
  userList = []
  result = []
  if platforms.findOne()?
    deckList = platforms.findOne().quodecks[1..6]
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
            generateScoreKurukshetra(deck)
          Meteor.call('insertAmpScore',platformName, leaderboardJSON)
        else
          console.log err
      )


Template.kurukshetraHealthModal.helpers
  leadB:()->
    getKurukshetraLeader()

  newLeadB:()->
    results = []
    teams=[{quoName:'Violet'},{quoName:'Indigo'},{quoName:'Blue'},{quoName:'Green'},{quoName:'Yellow'}]
    if ampQuoScore.findOne()? and platforms.findOne()?
      users = getUserOfTeam();
      baseConfig = getGameParams(platforms.findOne().gameName)
      _.forEach(getKurukshetraLeader(), (val, index)->
        a = {}
        a._id = val._id
        a.name = val.name
        a.strategies = val.strategies
        # score = if getGameMasterData().quoScores[index] > 0 then "Active" else "Defeated"
        # a.data = [{score: score}]
        a.data = []
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
              a.data.push {score: da.quoScores[index], selected: da.selectedAnswers[index], teamName: tVal.quoName, color: tVal.quoName.toLowerCase()}
            else
              a.data.push {score: 0, selected: "-", teamName: tVal.quoName, color: tVal.quoName.toLowerCase()}


          else
            a.data.push {score: 0, selected: "-", teamName: tVal.quoName, color: tVal.quoName.toLowerCase()}
        )
        
        a.criteria = []
        sIndex = _.indexOf(ampQuoScore.findOne().results[0].schema, val._id)
        # console.log(ampQuoScore.findOne().results[0].schemas);
        # console.log(val._id)
        console.log(sIndex)
        _.forEach(val.criteria, (cVal, cIndex)->
          a.criteria.push({cname: cVal.desc, status: if ampQuoScore.findOne().results[0].criterias[sIndex][cIndex].status then "defeated" else "undefeated"})
        )
        # a.data.push({score: getGameMasterData().quoScores[index]})
        a.gameMasterScore = getGameMasterData().quoScores[index]
        results.push a
      )
      console.log getInputJson()
      results



  leaderBoard1:()->
    results = []
    #I hate doing this but this cruel world ..............
    # teams=[{quoName:'Blue'},{quoName:'Green'},{quoName:'Indigo'},{quoName:'Orange'},{quoName:'Red'},{quoName:'Violet'},{quoName:'Yellow'}]
    teams=[{quoName:'Violet'},{quoName:'Indigo'},{quoName:'Blue'},{quoName:'Green'},{quoName:'Yellow'}]
    if ampQuoScore.findOne()? and platforms.findOne()?
      users = getUserOfTeam();
      baseConfig = getGameParams(platforms.findOne().gameName)
      _.forEach(platforms.findOne().quodecks, (val, index)->
        a = {}
        a.name = "Round "+ (index+1)
        score = if getGameMasterData().quoScores[index] > 0 then "Active" else "Defeated"
        # a.data = [{score: score}]
        a.data = [{}]
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

@getKurukshetraLeader = ()->
  if platforms.findOne()?
    rounds = platforms.findOne().quodecks[1..6]
    a = [
          {
            _id: rounds[0],
            name:"ROUND1",
            strategies:[
              {
                desc: "250 troops against Bheeshma, 250 troops against Drona"
              },
              {
                desc: "250 troops against Drona, 250 troops against Duryodhana"
              },
              {
                desc: "250 troops against Duryodhana, 250 troops against Bheeshma"
              },
              {
                desc: "500 troops against Bheeshma"
              }
            ],
            criteria:[
              {
                desc:"2,000 troops of Bheeshma"
              },
              {
                desc:"1,000 troops of Drona"
              },
              {
                desc:"500 troops of Duryodhana"
              }
            ]
          },
          {
            _id: rounds[1],
            name:"ROUND2",
            strategies:[
              {
                desc: "250 troops against Kripacharya, 250 troops against Dushasan"
              },
              {
                desc: "250 troops against Dushasan, 250 troops against Ashwathama"
              },
              {
                desc: "250 troops against Ashwathama, 250 troops against Kripacharya"
              },
              {
                desc: "500 troops against Kripacharya"
              }
            ],
            criteria:[
              {
                desc:"2,000 troops of Kripacharya"
              },
              {
                desc:"1,000 troops of Dushasan"
              },
              {
                desc:"500 troops of Ashwathama"
              }
            ]
          },
          {
            _id: rounds[2],
            name:"ROUND3",
            strategies:[
              {
                desc: "250 troops against Bheeshma, 250 troops against Jayadratha"
              },
              {
                desc: "250 troops against Jayadratha, 250 troops against Shakuni"
              },
              {
                desc: "250 troops against Shakuni, 250 troops against Bheeshma"
              },
              {
                desc: "500 troops against Bheeshma"
              }
            ],
            criteria:[
              {
                desc:"2,000 troops of Bheeshma"
              },
              {
                desc:"1,000 troops of Jayadratha"
              },
              {
                desc:"500 troops of Shakuni"
              }
            ]
          },
          {
            _id: rounds[3],
            name:"ROUND4",
            strategies:[
              {
                desc: "Arjun with Shikhandi"
              },
              {
                desc: "Arjun with 250 troops"
              },
              {
                desc: "Shikhandi with 250 troops"
              },
              {
                desc: "500 troops against the armies"
              }
            ],
            criteria:[
              {
                desc:"1,250 troops of Bheeshma"
              },
              {
                desc:"Bheeshma"
              }
            ]
          },
          {
            _id: rounds[4],
            name:"ROUND5",
            strategies:[
              {
                desc: "Yudishthir with Curse 3"
              },
              {
                desc: "Arjun"
              },
              {
                desc: "Curse 1"
              },
              {
                desc: "Curse 2"
              }
            ],
            criteria:[
              {
                desc:"Drona"
              },
              {
                desc:"Karna"
              }
            ]
          },
          {
            _id: rounds[5],
            name:"ROUND6",
            strategies:[
              {
                desc: "Bheem and Bet 1,000 points"
              },
              {
                desc: "Rulebreaker and Bet 1,000 points"
              },
              {
                desc: "Bheem with Rulebreaker"
              },
              {
                desc: "Bet 2,000 points"
              }
            ],
            criteria:[
              {
                desc:"Duryodhana"
              }
            ]
          }
        ]
    a
