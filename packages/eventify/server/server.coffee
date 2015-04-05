if Meteor.isServer
  Meteor.methods
    executeTriggerHandler:(methodname,methodArgs,ename)->
      console.log methodArgs
      global[methodname](methodArgs)
      if ename isnt -1
        for k in Object.keys(global)
          if global[k] instanceof Badge
            global[k].triggerEvent(ename,methodArgs)

  addBadgeToUser:(uid,badgeName)->
        Meteor.users.update({_id:uid},{$push:{badges:badgeName}})
