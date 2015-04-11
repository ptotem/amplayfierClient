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
        role:roles.findOne(u.personal_profile.role).rolename,
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

            zip.file('friends.csv', data)
            future.return(zip.generate({type: "base64"}))
      )


    ).run()
    return future.wait()



)