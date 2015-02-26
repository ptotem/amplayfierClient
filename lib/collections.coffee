@deckHtml = new Meteor.Collection("deckHtml");
@platforms = new Meteor.Collection('platforms');
@decks = new Meteor.Collection('decks');
@reports = new Meteor.Collection('reports');
@individualGameAttempts = new Meteor.Collection("individualGameAttempts")
@individualQuestionAttempts = new Meteor.Collection("individualQuestionAttempts")


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

# @decks = new Meteor.Collection('decks',remote)
# # @assetFiles = new Meteor.Collection('items', remote);

# remote.subscribe('tempDecks', ()->
#   items = assetFiles.find().fetch();
#   console.log(items.length);
# )
