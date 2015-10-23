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
          Meteor.call('upsertAmpQuoInputJson', platformName, returnData)
          @leaderboardJSON = generateLeaderboardConfig(userList,gameName)
          
          for deck in deckList
            generateScoreKurukshetra(deck)
          Meteor.call('insertAmpScore',platformName, leaderboardJSON)
        else
          console.log err1
      )


Template.kurukshetraHealthModal.helpers
  leadB:()->
    getKurukshetraLeader()

  newLeadB:()->
    results = []
    teams=[{quoName:'Violet'},{quoName:'Indigo'},{quoName:'Blue'},{quoName:'Green'},{quoName:'Yellow'}]
    if ampQuoScore.findOne()? and platforms.findOne()? and ampQuoInputJson.findOne()? and ampQuoInputJson.findOne().inputJson.length > 0
      users = getUserOfTeam()
      lastestInputJson = ampQuoInputJson.findOne().inputJson
      baseConfig = getGameParams(platforms.findOne().gameName)
      _.forEach(getKurukshetraLeader(), (val, index)->
        a = {}
        a._id = val._id
        a.name = val.name
        a.strategies = val.strategies
        a.data = []
        _.forEach(teams,(tVal, iIndex)->
          if _.where(lastestInputJson,{quoid: val._id}).length > 0 and _.where(lastestInputJson,{quoid: val._id})[0].scores.length > 0
            console.log("innn")
            if _.where(_.where(lastestInputJson,{quoid: val._id})[0].scores, {team: tVal.quoName}).length > 0
              use = _.where(_.where(lastestInputJson,{quoid: val._id})[0].scores, {team: tVal.quoName})[0]
              da =  _.where(ampQuoScore.findOne().results[0].data,{userid:use.userid})[0]
              quoIndex = _.indexOf(da.criterias,val._id)
              a.data.push {score: da.quoScores[quoIndex], selected: da.selectedAnswers[quoIndex], teamName: tVal.quoName, color: tVal.quoName.toLowerCase()}
            else
              a.data.push {score: 0, selected: "-", teamName: tVal.quoName, color: tVal.quoName.toLowerCase()}
          else
            console.log "ffff"
            a.data.push {score: 0, selected: "-", teamName: tVal.quoName, color: tVal.quoName.toLowerCase()}  
        )
        a.criteria = []
        sIndex = _.indexOf(ampQuoScore.findOne().results[0].schema, val._id)
        console.log(sIndex)
        _.forEach(val.criteria, (cVal, cIndex)->
          a.criteria.push({cname: cVal.desc, status: if ampQuoScore.findOne().results[0].criterias[sIndex][cIndex].status then "defeated" else "undefeated"})
        )
        
        a.gameMasterScore = getGameMasterData().quoScores[index]
        results.push a
      )
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
                desc: "100 vs Bheeshma, 50 vs Drona, 50 vs Karna"
              },
              {
                desc: "100 vs Bheeshma, 50 vs Drona, 25 vs Karna, 25 vs Duryodhana"
              },
              {
                desc: "75 vs Bheeshma, 50 vs Drona, 50 vs Karna, 25 vs Duryodhana"
              },
              {
                desc: "50 vs Bheeshma, 50 vs Drona, 50 vs Karna, 50 vs Duryodhana"
              }
            ],
            criteria:[
              {
                desc:"350 troops of Bheeshma"
              },
              {
                desc:"250 troops of Drona"
              },
              {
                desc:"150 troops of Karna"
              },
              {
                desc:"50 troops of Duryodhana"
              }
            ]
          },
          {
            _id: rounds[1],
            name:"ROUND2",
            strategies:[
              {
                desc: "100 vs Bheeshma, 75 vs Drona"
              },
              {
                desc: "75 vs Bheeshma, 75 vs Drona, 25 vs Karna"
              },
              {
                desc: "75 vs Bheeshma, 50 vs Drona, 50 vs Karna"
              },
              {
                desc: "25 vs Bheeshma, 50 vs Drona, 50 vs Karna, 50 vs Duryodhana"
              }
            ],
            criteria:[
              {
                desc:"350 troops of Bheeshma"
              },
              {
                desc:"250 troops of Drona"
              },
              {
                desc:"150 troops of Karna"
              },
              {
                desc:"50 troops of Duryodhana"
              }
            ]
          },
          {
            _id: rounds[2],
            name:"ROUND3",
            strategies:[
              {
                desc: "100 vs Bheeshma, 75 vs Drona"
              },
              {
                desc: "75 vs Bheeshma, 75 vs Drona, 25 vs Karna"
              },
              {
                desc: "75 vs Bheeshma, 50 vs Drona, 50 vs Karna"
              },
              {
                desc: "25 vs Bheeshma, 50 vs Drona, 50 vs Karna, 50 vs Duryodhana"
              }
            ],
            criteria:[
              {
                desc:"350 troops of Bheeshma"
              },
              {
                desc:"250 troops of Drona"
              },
              {
                desc:"150 troops of Karna"
              },
              {
                desc:"50 troops of Duryodhana"
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
                desc: "Arjun with 50 troops"
              },
              {
                desc: "Shikhandi with 100 troops"
              },
              {
                desc: "200 troops"
              }
            ],
            criteria:[
              {
                desc:"350 troops of Bheeshma"
              },
              {
                desc:"Bheeshma, The Immortal General"
              }
            ]
          },
          {
            _id: rounds[4],
            name:"ROUND5",
            strategies:[
              {
                desc: "Yudishthir and Arjun"
              },
              {
                desc: "Yudishthir and 100 points if both generals are defeated"
              },
              {
                desc: "Arjun and 200 points if both generals are defeated"
              },
              {
                desc: "300 points if both generals are defeated"
              }
            ],
            criteria:[
              {
                desc:"Drona, The Revered Teacher"
              },
              {
                desc:"Karna, The Honorable"
              }
            ]
          },
          {
            _id: rounds[5],
            name:"ROUND6",
            strategies:[
              {
                desc: "Do Nothing"
              },
              {
                desc: "Put Bheem and Bet 150 points (Gain 150 or Lose 150)"
              },
              {
                desc: "Break the Rule and Bet 300 points (Gain 300 or Lose 300)"
              },
              {
                desc: "Bet 500 points (Gain 500 or Lose 500)"
              }
            ],
            criteria:[
              {
                desc:"Duryodhana, The Final Enemy"
              }
            ]
          }
        ]
    a
