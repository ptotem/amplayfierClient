


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

@firstLand = new Badge('firstTimeLandModal','/assets/badgeimages/wellstarted.png',[score])
firstLand.on('assign',(t)->
  oldcurrency = currency.getValue()
  newcurrency = oldcurrency + 100
  currency.setValue(newcurrency)
  Meteor.users.update({_id:Meteor.userId()},{$addToSet:{badges:t}})
)
@chapterCompletion = new Badge("chapterCompleteMedal",'/assets/badgeimages/milestone.png',[score,currency])
chapterCompletion.on('assign',(t)->
  oldcurrency = currency.getValue()
  newcurrency = oldcurrency + 50
  currency.setValue(newcurrency)
  Meteor.users.update({_id:Meteor.userId()},{$addToSet:{badges:t}})
)


@allThroughDecks = new Badge("allDeckFullScoreMedal",'/assets/badgeimages/through.png',[score,currency])
allThroughDecks.on('assign',(t)->
  console.log "all through assigned"
  oldcurrency = currency.getValue()
  newcurrency = oldcurrency + 200
  currency.setValue(newcurrency)
  Meteor.users.update({_id:Meteor.userId()},{$addToSet:{badges:t}})
)




@allChapterCompletion = new Badge("allChapterCompleteMedal",'/assets/badgeimages/alldone.png',[score,currency])
allChapterCompletion.on('assign',(t)->

  oldcurrency = currency.getValue()
  newcurrency = oldcurrency + 100
  currency.setValue(newcurrency)
  Meteor.users.update({_id:Meteor.userId()},{$addToSet:{badges:t}})
  flag = true
  for n in platformData.nodes
    if n.decks?
      for d in n.decks
  #      console.log n
        slideRep = _.groupBy(reports.find({userId:Meteor.userId(),deckId:d}).fetch(),(x)->
          x.slideId
        )
        if _.isEmpty(slideRep)
          flag = false
        for k in Object.keys(slideRep)
          console.log "---------------"
          console.log slideRep[k]
          console.log  _.compact(_.pluck(slideRep[k],'scorePercentage'))
          if  _.compact(_.pluck(slideRep[k],'scorePercentage')).indexOf(100) is -1
            flag = false
  console.log flag
  if flag
    allThroughDecks.assign()






#    reports.find({userId:Meteor.userId,})

)


#nodeOpenMedal.onAssign(score,'addScore')
#
#deckOpenMedal.onAssign(score,'mScore')




@loginEvent = new AppEvent('userLogin','client',['registerLogin'])
@logoutEvent = new AppEvent('userLogout','client',['registerLogout'])
@landOnWrapperEvent = new AppEvent('landOnWrapper','client',['landOnWrapper'])
@newUserEvent = new AppEvent('newUser','both',['newUser'])
@nodeOpenEvent = new AppEvent('nodeOpen','client',['nodeOpen'])
@deckOpenEvent = new AppEvent('deckOpen','client',['deckOpen'])

