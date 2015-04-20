if Meteor.isServer
  @initDMS = (mode,options)->
    setMode(mode)
    setOptions(options)


  @setMode = (mode)->
    @dmsMode = mode
  @getMode = ()->
    dmsMode
  @setOptions = (options)->
    console.log options

    @s3Options = options

  Meteor.publish('systemFiles',(uid)->
    this.ready()

#    pid = platforms.findOne({tenantName: pname})._id
    systemFiles.find({owner:uid})
  )
  Meteor.publish('gridFiles',(uid)->
    this.ready()

    #    pid = platforms.findOne({tenantName: pname})._id
    gridFiles.find({owner:uid})
  )
  Meteor.publish('s3Files',(uid)->
    this.ready()

    #    pid = platforms.findOne({tenantName: pname})._id
    s3Files.find({owner:uid})
  )

  Meteor.methods
      getDmsMode:()->
        getMode()