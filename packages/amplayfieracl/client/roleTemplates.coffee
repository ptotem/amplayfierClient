if Meteor.isClient
  @can = (code)->
    roles.findOne(Meteor.user().personal_profile.role).capabilities.indexOf(code) isnt -1

  Template.roleList.helpers
    listOfRoles:()->
      roles.find().fetch()
    capabilityList:()->
      capabilities.find().fetch()
    capabilityAdded:(code)->
      if Session.get('currentRole')?
        roles.findOne(Session.get('currentRole')).capabilities.indexOf(code) isnt -1


  Template.roleList.events

    'click .manage-role':(e)->
      $('.role-list').hide()
      $('.capability-list').show()
      Session.set('currentRole',this._id)
    'click .delete-role':(e)->
      roles.remove({_id:this._id})
    'click .show-roles':(e)->
      $('.role-list').show()
      $('.capability-list').hide()
    'click .fix-capability':(e)->
      boxVals = _.map $('.capaInRole:checked'), (el) ->
          $(el).val()
      roles.update({_id:Session.get('currentRole')},{$set:{capabilities:boxVals}})
      $('.show-roles').trigger('click')






  Template.roleList.rendered = ->

    Session.set('acluniqkey',this.data.uniqKey)
    Meteor.subscribe('roles',this.data.uniqKey)
    Meteor.subscribe('capabilities')
    $('.capability-list').hide()

  Template.newRoleForm.events
    'submit form':(e)->
      uk = Session.get('acluniqkey')
      addRoles($(e.currentTarget).find('#rolename').val(),$(e.currentTarget).find('#roledesc').val(),[],uk)
#      roles.insert({rolename:$(e.currentTarget).find('#rolename').val(),roledesc:$(e.currentTarget).find('#roledesc').val()})
      e.preventDefault()
      $('.show-roles').trigger('click')

  Template.roleAssignment.helpers
    listOfUsers:()->
      Meteor.users.find().fetch()
    listOfRoles:()->
      roles.find().fetch()
    getRoleName:(rid)->
      if rid?
        roles.findOne(rid).rolename
      else
        "Not assigned"

  Template.roleAssignment.events
    'change .userRoleAssignment':(e)->
      Meteor.call('updateUserRole',this._id,$(e.currentTarget).val(),(err,res)->
        if res
          createNotification("Role is assigned",1)
      )
