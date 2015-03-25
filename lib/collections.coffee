


@deckHtml = new Meteor.Collection("deckHtml");
@deckJs = new Meteor.Collection("deckJs");
@platforms = new Meteor.Collection('platforms');
@decks = new Meteor.Collection('decks');
@reports = new Meteor.Collection('reports');
@individualGameAttempts = new Meteor.Collection("individualGameAttempts")
@individualQuestionAttempts = new Meteor.Collection("individualQuestionAttempts")
@reportMeta = new Meteor.Collection("reportMeta")
@gameData = new Meteor.Collection("gameData")
@customizationDecks = new Meteor.Collection("customizationDecks")
@archivePlatforms = new Meteor.Collection("archivePlatforms")
@platformType = new Meteor.Collection("platformType")
@userCompletions = new Meteor.Collection("userCompletions")
@panelReport = new Meteor.Collection("panelReport")
@userActivity = new Meteor.Collection('userActivity');


@userActivity.allow
  insert:(userId, role) ->
    true
  update:(userId, doc, fieldNames, modifier)->

    true
  remove:(userId, doc)->
    true

@reports.allow
  insert:(userId, role) ->
    true
  update:(userId, doc, fieldNames, modifier)->

    true
  remove:(userId, doc)->
    true
@userCompletions.allow
  insert:(userId, role) ->
    true
  update:(userId, doc, fieldNames, modifier)->

    true
  remove:(userId, doc)->
    true



# remote = DDP.connect('http://localhost:3000/');

imageStore = new FS.Store.GridFS("assetFiles",
 # mongoUrl: "mongodb://127.0.0.1:3001/meteor/" # optional, defaults to Meteor's local MongoDB
# #  transformWrite: myTransformWriteFunction #optional
# #  transformRead: myTransformReadFunction #optional
# #  maxTries: 1 # optional, default 5
#   chunkSize: 1024 * 1024 # optional, default GridFS chunk size in bytes (can be overridden per file).
)
@assetFiles = new FS.Collection("assetFiles",
  stores:[imageStore]
  # connection:remote

)

@gameFiles = new FS.Collection("gameFiles",

  stores: [

    new FS.Store.FileSystem("gameFiles",{path:"/var/www/gamedatatest"})

  ]
)


@excelFiles = new FS.Collection("excelFiles",

  stores: [
    new FS.Store.FileSystem("raw",{path: "/var/www/userlistfiles"})
  ]
)

@repositoryFiles = new FS.Collection("repoFiles",
	stores: [
    new FS.Store.FileSystem("repo",{path: "/var/www/repofiles"})
  ]

)



@repositoryFiles.on('stored', (fileObj, storeName) ->
  if storeName is "repo"
    Fiber = Npm.require('fibers');
    Future = Npm.require('fibers/future');
    future = new Future();
    Fiber(()->
    	repositoryFiles.update({_id:fileObj._id},{$set:{stored:true}})
    ).run()
	
    
)


# @decks = new Meteor.Collection('decks',remote)
# # @assetFiles = new Meteor.Collection('items', remote);

# remote.subscribe('tempDecks', ()->
#   items = assetFiles.find().fetch();
#   console.log(items.length);
# )

@loginEvent = new AppEvent('userLogin','client','registerLogin')
@logoutEvent = new AppEvent('userLogout','client','registerLogout')
@landOnWrapperEvent = new AppEvent('landOnWrapper','client','landOnWrapper')
@newUserEvent = new AppEvent('newUser','both','newUser')
@nodeOpenEvent = new AppEvent('nodeOpen','client','nodeOpen')
@deckOpenEvent = new AppEvent('deckOpen','client','deckOpen')

