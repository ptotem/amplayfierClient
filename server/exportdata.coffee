jsZip      = Meteor.npmRequire 'jszip'
xmlBuilder = Meteor.npmRequire 'xmlbuilder'
fastCsv    = Meteor.npmRequire 'fast-csv'
zip = new jsZip()

_.unwind = (o, field, toField) ->
  console.log "Inside unwind"
  if !toField
    toField = field
  _.map o[field], (val) ->
    cloned = _.clone(o)
    cloned[toField] = val
    cloned


_.groupByMulti = (obj, values, context) ->
  if !values.length
    return obj
  byFirst = _.groupBy(obj, values[0], context)
  rest = values.slice(1)
  for prop of byFirst
    byFirst[prop] = _.groupByMulti(byFirst[prop], rest, context)
  byFirst


Meteor.methods(
  exportData: () ->
    # Make sure to "Check" the userId variable.
#    check(userId,String)
  # We'll handle our actual export here.
    Fiber = Npm.require('fibers')
    Future = Npm.require('fibers/future')
    future = new Future()

    users = Meteor.users.find().fetch()
    finalDataJSON = []
    userNodeCompletionData = userNodeCompletions.find().fetch()
    for unc in userNodeCompletionData
      u = Meteor.users.findOne(unc.userId)
      finalDataJSON.push({
        first_name:u.personal_profile.first_name,
        last_name:u.personal_profile.last_name,
        profile:u.profile,
        # role:roles.findOne(u.personal_profile.role).rolename,
        role:u.role,
        node_number:unc.nodeSeq,
        node_name:platforms.findOne(unc.platformId).nodes[unc.nodeSeq].title,
        status:unc.status,
        completion_date:new Date(unc.createdAt).toString(),
        score:100




      })


    Fiber(()->
      csv =  fastCsv
      csv.writeToString(finalDataJSON,
        {headers: true},
        (error,data) ->
          if error
            console.log error
          else

            zip.file('node.csv', data)
            future.return(zip.generate({type: "base64"}))
      )


    ).run()
    return future.wait()



# Tata Reports
  exportTataReports: (pid) ->
    # Make sure to "Check" the userId variable.
#    check(userId,String)
  # We'll handle our actual export here.
    Fiber = Npm.require('fibers')
    Future = Npm.require('fibers/future')
    future = new Future()

    users = Meteor.users.find().fetch()
    finalDataJSON = []
    status = ""
    score = ""
    deckName = []
    userNodeCompletionData = userNodeCompletions.find().fetch()
    platformsId = []
    endResult = []
    pf = platforms.findOne({_id:pid})
    platformsId.push(pf._id)
    for sp in pf.subPlatforms
      p = platforms.findOne({tenantId: sp.subTenantId})
      platformsId.push p._id
    console.log platformsId
    l = _.map(_.flatten(_.map(reports.find({platformId:{$in:platformsId}}).fetch(), (val) ->
            _.unwind(val, 'slideData', 'sd')
          )), (v, i) ->
            finalres={}
            v.first_name = Meteor.users.findOne({_id:v.userId}).personal_profile.first_name
            v.last_name = Meteor.users.findOne({_id:v.userId}).personal_profile.last_name
            v.email = Meteor.users.findOne({_id:v.userId}).personal_profile.email
            v.gameName = v.sd.gameName
            v.percentageScore = v.sd.percentageScore
            finalres.first_name = v.first_name
            finalres.last_name = v.last_name
            finalres.email = v.email
            finalres.email = v.email
            finalres.gameName = v.gameName
            finalres.percentageScore = v.percentageScore
            
            return finalres

        )
    Fiber(()->
      csv =  fastCsv
      csv.writeToString(l,
        {headers: true},
        (error,data) ->
          if error
            console.log error
          else

            zip.file('tata.csv', data)
            future.return(zip.generate({type: "base64"}))
      )


    ).run()
    return future.wait()
# Tata Reports






















  exportDeckDataForAllUsers: () ->
    # Make sure to "Check" the userId variable.
#    check(userId,String)
  # We'll handle our actual export here.
    Fiber = Npm.require('fibers')
    Future = Npm.require('fibers/future')
    future = new Future()

    users = Meteor.users.find().fetch()
    finalDataJSON = []
    userDeckCompleteData = reports.find({deckComplete:true}).fetch()
    for unc in userDeckCompleteData
      u = Meteor.users.findOne(unc.userId)
      finalDataJSON.push({
        first_name:u.personal_profile.first_name,
        last_name:u.personal_profile.last_name,
        profile:u.profile,
        # role:roles.findOne(u.personal_profile.role).rolename,
        role:u.role,
        deck_name:deckHtml.findOne({deckId:unc.deckId}).name,
        completion_date:new Date(unc.createdAt).toString(),
        score:100
      })


    Fiber(()->
      csv =  fastCsv
      csv.writeToString(finalDataJSON,
        {headers: true},
        (error,data) ->
          if error
            console.log error
          else

            zip.file('decks.csv', data)
            future.return(zip.generate({type: "base64"}))
      )


    ).run()
    return future.wait()



  # exportAllDeckDataForAllUsers: (pid) ->
#     # Make sure to "Check" the userId variable.
# #    check(userId,String)
#   # We'll handle our actual export here.
#     Fiber = Npm.require('fibers')
#     Future = Npm.require('fibers/future')
#     future = new Future()

#     users = Meteor.users.find().fetch()
#     finalDataJSON = []
#     status = ""
#     score = ""
#     userNodeCompletionData = userNodeCompletions.find().fetch()
#     for unc in Meteor.users.find({platform:pid}).fetch()
#       for node in reports.find({deckComplete:true}).fetch()
#         if userCompletions.find({userId:unc._id}).fetch().length isnt 0
#           score = _.sortBy(userCompletions.find({userId:unc._id}).fetch(), 'createdAt')[0].perscore
#         if userNodeCompletions.findOne({userId:unc._id,nodeSeq:node.sequence})?
#           status = "complete"
#         else
#           status = "incomplete"
#       # u = Meteor.users.findOne(unc.userId)
#         finalDataJSON.push({
#           first_name:unc.personal_profile.first_name,
#           last_name:unc.personal_profile.last_name,
#           profile:unc.profile,
#           role:unc.role,
#           node_number:node.nodeSeq,
#           node_name:node.title,
#           status:status,
#           completion_date:new Date(unc.createdAt).toString(),
#           score:score

#         })


#     Fiber(()->
#       csv =  fastCsv
#       csv.writeToString(finalDataJSON,
#         {headers: true},
#         (error,data) ->
#           if error
#             console.log error
#           else

#             zip.file('alldecks.csv', data)
#             future.return(zip.generate({type: "base64"}))
#       )


#     ).run()
#     return future.wait()



  exportAllDeckDataForAllUsers: (pid) ->
    Fiber = Npm.require('fibers')
    Future = Npm.require('fibers/future')
    future = new Future()

    users = Meteor.users.find().fetch()
    finalDataJSON = []
    status = ""
    score = ""
    deckName = []
    userNodeCompletionData = userNodeCompletions.find().fetch()
    platformsId = []
    endResult = []
    pf = platforms.findOne({_id:pid})
    platformsId.push(pf._id)
    for sp in pf.subPlatforms
      p = platforms.findOne({tenantId: sp.subTenantId})
      platformsId.push p._id
    console.log platformsId
    l = _.map(_.flatten(_.map(reports.find({platformId:{$in:platformsId}}).fetch(), (val) ->
            _.unwind(val, 'slideData', 'sd')
          )), (v, i) ->
            v.slideId = v.sd.slideId
            v.slideTime = v.sd.slideTime
            v.slideScore = v.sd.slideScore
            return v
        )
    temp = _.groupBy(l,'slideId')
    k = _.map(temp, (v, i) ->
          a = _.map(_.groupBy(v,"userId") , (vi, ii)->
                   ).length
          return {
            deckId: _.pluck(v, 'deckId')[0]
            deckName: deckHtml.findOne({deckId:_.pluck(v, 'deckId')[0]}).name
            slideId: i
            noOfViews: v.length
            noOfUsers: a
            avgNoOfViewPerUser: v.length/a
            timeSpend: _.sum(_.pluck(v,'slideTime'))/a
            avgScore: _.sum(_.pluck(v,'slideScore'))/a

          }
        )

    Fiber(()->
      csv =  fastCsv
      csv.writeToString(k,
        {headers: true},
        (error,data) ->
          if error
            console.log error
          else

            zip.file('alldecks.csv', data)
            future.return(zip.generate({type: "base64"}))
      )


    ).run()
    return future.wait()


  exportAllNodeDataForAllUsers: (pid) ->
    # Make sure to "Check" the userId variable.
#    check(userId,String)
  # We'll handle our actual export here.
    Fiber = Npm.require('fibers')
    Future = Npm.require('fibers/future')
    future = new Future()

    users = Meteor.users.find().fetch()
    finalDataJSON = []
    status = ""
    score = ""
    userNodeCompletionData = userNodeCompletions.find().fetch()
    for unc in Meteor.users.find({platform:pid}).fetch()
      for node in platforms.findOne(pid).nodes
        if userCompletions.find({userId:unc._id}).fetch().length isnt 0
          score = _.sortBy(userCompletions.find({userId:unc._id}).fetch(), 'createdAt')[0].perscore
        if userNodeCompletions.findOne({userId:unc._id,nodeSeq:node.sequence})?
          status = "complete"
        else
          status = "incomplete"
      # u = Meteor.users.findOne(unc.userId)
        finalDataJSON.push({
          first_name:unc.personal_profile.first_name,
          last_name:unc.personal_profile.last_name,
          profile:unc.profile,
          role:unc.role,
          node_number:node.nodeSeq,
          node_name:node.title,
          status:status,
          completion_date:new Date(unc.createdAt).toString(),
          score:score

        })


    Fiber(()->
      csv =  fastCsv
      csv.writeToString(finalDataJSON,
        {headers: true},
        (error,data) ->
          if error
            console.log error
          else

            zip.file('allnode.csv', data)
            future.return(zip.generate({type: "base64"}))
      )


    ).run()
    return future.wait()



)
