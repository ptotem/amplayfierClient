if Meteor.isServer


  Meteor.publish('roles',(uk)->
    this.ready()
    roles.find({unikey:uk})
  )
  Meteor.publish('capabilities',()->
    this.ready()
    capabilities.find()
  )

  @addCapabilities = (cname,ccode)->
    capabilities.insert({name:cname,code:ccode})
  @resetCapabilities = ()->
    capabilities.remove({})