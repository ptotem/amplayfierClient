jsZip      = Meteor.npmRequire 'jszip'
xmlBuilder = Meteor.npmRequire 'xmlbuilder'
fastCsv    = Meteor.npmRequire 'fast-csv'
zip = new jsZip()



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



  exportAllDeckDataForAllUsers: (pid) ->
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
      for node in reports.find({deckComplete:true}).fetch()
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
