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
    userNodeCompletionData = userNodeCompletions.find().fetch()
    Fiber(()->
      csv =  fastCsv
      csv.writeToString(userNodeCompletionData,
        {headers: true},
        (error,data) ->
          if error
            console.log error
          else
            console.log data
            zip.file('friends.csv', data)
            future.return(zip.generate({type: "base64"}))
      )


    ).run()
    return future.wait()



)