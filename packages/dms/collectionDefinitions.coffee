gridStore = new FS.Store.GridFS("gridFiles",
  chunkSize: 1024 * 1024*5 # optional, default GridFS chunk size in bytes (can be overridden per file).
)
@gridFiles = new FS.Collection("gridFiles",
  stores:[gridStore]

)

@systemFiles = new FS.Collection("systemFiles",

  stores: [

    new FS.Store.FileSystem("systemFiles",{path:"/var/www/systemFiles"})

  ]
)


@systemFiles.allow
  insert:(userId, role) ->
    true
  update:(userId, doc, fieldNames, modifier)->

    true
  remove:(userId, doc)->
    true
  download:(userId,doc)->
    true
@gridFiles.allow
  insert:(userId, role) ->
    true
  update:(userId, doc, fieldNames, modifier)->

    true
  remove:(userId, doc)->
    true
  download:(userId,doc)->
    true


if Meteor.isServer
  s3Store = new (FS.Store.S3)('s3Files',
    region: Meteor.settings.region
    accessKeyId: Meteor.settings.accessKeyId
    secretAccessKey: Meteor.settings.secretAccessKey
    bucket: Meteor.settings.bucket
    ACL: 'private'
    folder:Meteor.settings.folder

    maxTries: 1)



  @s3Files = new FS.Collection("s3Files", {
    stores: [s3Store]
  });

if Meteor.isClient
  s3Store = new (FS.Store.S3)



  @s3Files = new FS.Collection("s3Files", {
    stores: [s3Store]
  });

