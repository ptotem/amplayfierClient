@deckHtml = new Meteor.Collection("deckHtml");
@deckJs = new Meteor.Collection("deckJs");
@platforms = new Meteor.Collection('platforms');
@decks = new Meteor.Collection('decks');
@reports = new Meteor.Collection('reports');
@individualGameAttempts = new Meteor.Collection("individualGameAttempts")
@individualQuestionAttempts = new Meteor.Collection("individualQuestionAttempts")
@reportMeta = new Meteor.Collection("reportMeta")
@gameData = new Meteor.Collection("gameData")
@gameValData = new Meteor.Collection("gameValData")

@customizationDecks = new Meteor.Collection("customizationDecks")
@archivePlatforms = new Meteor.Collection("archivePlatforms")
@platformType = new Meteor.Collection("platformType")
@userCompletions = new Meteor.Collection("userCompletions")
@panelReport = new Meteor.Collection("panelReport")
@userActivity = new Meteor.Collection('userActivity');
@userNodeStatus = new Meteor.Collection('userNodeStatus');
@systemRewards = new Meteor.Collection('systemRewards');
@scoreQuestions = new Meteor.Collection('scoreQuestions')
@assesments = new Meteor.Collection('assesments')
@userNodeCompletions = new Meteor.Collection('userNodeCompletions')
@assesmentScore = new Meteor.Collection('assesmentScore')
@systemBadges = new Meteor.Collection('systemBadges')
@platformUserFeedbacks = new Meteor.Collection('platformUserFeedbacks')
@ampQuoScore = new Meteor.Collection('ampQuoScore')
@quoScoreConfig = new Meteor.Collection('quoScoreConfig')
@ampQuoInputJson = new Meteor.Collection('ampQuoInputJson')

@platforms.allow
  insert:(userId, role) ->
    true
  update:(userId, doc, fieldNames, modifier)->

    true
  remove:(userId, doc)->
    true

@platformUserFeedbacks.allow
  insert:(userId, role) ->
    true
  update:(userId, doc, fieldNames, modifier)->

    true
  remove:(userId, doc)->
    true

@scoreQuestions.allow
  insert:(userId, role) ->
    true
  update:(userId, doc, fieldNames, modifier)->

    true
  remove:(userId, doc)->
    true

@assesments.allow
  insert:(userId, role) ->
    true
  update:(userId, doc, fieldNames, modifier)->

    true
  remove:(userId, doc)->
    true
@gameValData.allow
  insert:(userId, role) ->
    true
  update:(userId, doc, fieldNames, modifier)->

    true
  remove:(userId, doc)->
    true

@assesmentScore.allow
  insert:(userId, role) ->
    true
  update:(userId, doc, fieldNames, modifier)->

    true
  remove:(userId, doc)->
    true


@platforms.deny
  update:(uid,docs,fields,modifier)->
    if fields.indexOf('tenantId') isnt -1 or fields.indexOf('tenantName') isnt -1
      true
    else
      false


@userActivity.allow
  insert:(userId, role) ->
    true
  update:(userId, doc, fieldNames, modifier)->

    true
  remove:(userId, doc)->
    true
@systemRewards.allow
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
    console.log doc
    true
  remove:(userId, doc)->
    true
@userCompletions.allow
  insert:(userId, role) ->
    false
  update:(userId, doc, fieldNames, modifier)->

    false
  remove:(userId, doc)->
    false
@userNodeCompletions.allow
  insert:(userId, role) ->
    false
  update:(userId, doc, fieldNames, modifier)->

    false
  remove:(userId, doc)->
    false


@reportMeta.allow
  insert:(userId, role) ->
    true
  update:(userId, doc, fieldNames, modifier)->

    true
  remove:(userId, doc)->
    true

Meteor.users.allow
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

@assetFiles.allow
  insert:(userId, role) ->
    true
  update:(userId, doc, fieldNames, modifier)->

    true
  remove:(userId, doc)->
    true
  download:(userId,doc)->
    true

@gameFiles = new FS.Collection("gameFiles",

  stores: [

    new FS.Store.FileSystem("gameFiles",{path:"/var/www/gamedatatest"})

  ]
)

@assetFiles.on('stored', (fileObj, storeName) ->
  if storeName is "assetFiles"
    Fiber = Npm.require('fibers');
    Future = Npm.require('fibers/future');
    future = new Future();
    Fiber(()->
      assetFiles.update({_id:fileObj._id},{$set:{stored:true}})
    ).run()


)

@excelFiles = new FS.Collection("excelFiles",

  stores: [
    new FS.Store.FileSystem("raw",{path: "/var/www/userlistfiles"})
  ]
)


@excelFiles.on("stored",(fileObj,storeName)->

  if storeName is "raw"
    Fiber = Npm.require('fibers');
    Future = Npm.require('fibers/future');
    future = new Future();
    Fiber(()->
      if excelFiles.findOne(fileObj._id)?
        # console.log fileObj
        excelFiles.update({_id:fileObj._id},{$set:{stored:true}})
      # console.log fileObj.url()
    ).run()

)




@excelFiles.allow
  insert:(userId, role) ->
    true
  update:(userId, doc, fieldNames, modifier)->

    true
  remove:(userId, doc)->
    true

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

#System variable definition
@currency = new SysVar('currency')
@score = new SysVar('points')
score.assignUpdateRoutine('addScore','setScore')
score.assignGetValFunction('getScore')
currency.assignUpdateRoutine('addCurrency','setCurrency')
currency.assignGetValFunction('getCurrency')


#Define badges
@nodeOpenMedal = new Badge('nodeOpenMedal','/assets/badgeimages/wellstarted.png',[score])

@deckOpenMedal = new Badge('deckOpenMedal','/assets/badgeimages/wellstarted.png',[score])
nodeOpenMedal.on('assign',(t)->

  score.setValue(10)
)



#nodeOpenMedal.onAssign(score,'addScore')
#
#deckOpenMedal.onAssign(score,'mScore')



#
@loginEvent = new AppEvent('userLogin','both',['registerLogin'])
@logoutEvent = new AppEvent('userLogout','client',['registerLogout'])
#@landOnWrapperEvent = new AppEvent('landOnWrapper','client',['landOnWrapper'])
#@newUserEvent = new AppEvent('newUser','both',['newUser'])
#@nodeOpenEvent = new AppEvent('nodeOpen','client',['nodeOpen'])
#@deckOpenEvent = new AppEvent('deckOpen','client',['deckOpen'])
@deckCompleteEvent = new AppEvent('deckComplete','server',['deckComplete'])
@chapterCompleteEvent = new AppEvent('chapterComplete','server',['chapterComplete'])
@allChapterCompleteEvent = new AppEvent('allChapterComplete','server',['allChapterComplete'])
