if Meteor.isClient
  @can = (code)->
    console.log Meteor.user().personal_profile.role
    rid = Meteor.user().personal_profile.role
    console.log roles.find().fetch()
    roles.findOne(rid).capabilities.indexOf(code) isnt -1

  Template.manageRoleModal.events
    'click .remove-modal': (e) ->
      $('.modal').modal('hide')
      $('.modal').remove()
      $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"} )
      $(".modal-backdrop").hide();
    'click .fix-capability':(e)->
      boxVals = _.map $('.capaInRole:checked'), (el) ->
        $(el).val()
      roles.update({_id:Session.get('currentRole')},{$set:{capabilities:boxVals}})
      $('.show-roles').trigger('click')

  Template.manageRoleModal.helpers
    capabilityList:()->
      capabilities.find().fetch()
    capabilityAdded:(code)->
      if Session.get('currentRole')?
        roles.findOne(Session.get('currentRole')).capabilities.indexOf(code) isnt -1

  Template.roleList.helpers
    listOfRoles:()->
      roles.find().fetch()

    capabilityList:()->
        capabilities.find().fetch()

    capabilityAdded:(code)->
      if Session.get('currentRole')?
        roles.findOne(Session.get('currentRole')).capabilities.indexOf(code) isnt -1

  Template.roleListThemeView.helpers
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

  Template.roleListThemeView.events
    'click .manage-role':(e)->
      showModal('manageRoleModal',{},'main-wrapper-page-new')
      # $('.role-list').hide()
      # $('.capability-list').show()
      Session.set('currentRole',this._id)
    'click .delete-role':(e)->
      roles.remove({_id:this._id})
    'click .show-roles':(e)->
      $('.role-list').show()
      $('.capability-list').hide()


  Template.roleList.rendered = ->
    Session.set('acluniqkey',this.data.uniqKey)
    Meteor.subscribe('roles',this.data.uniqKey)
    Meteor.subscribe('capabilities')
    $('.capability-list').hide()

  Template.roleAssignmentThemeView.rendered = ->
    $('select').selectize();
    Session.set('acluniqkey',this.data.uniqKey)
    Meteor.subscribe('roles',this.data.uniqKey)
    Meteor.subscribe('capabilities')
    # $('.capability-list').hide()

  Template.newRoleForm.events
    'submit form':(e)->
      uk = Session.get('acluniqkey')
      addRoles($(e.currentTarget).find('#rolename').val(),$(e.currentTarget).find('#roledesc').val(),[],uk)
#      roles.insert({rolename:$(e.currentTarget).find('#rolename').val(),roledesc:$(e.currentTarget).find('#roledesc').val()})
      e.preventDefault()
      $('.show-roles').trigger('click')

  Template.newRoleFormThemeView.events
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

  Template.roleAssignmentThemeView.helpers
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

  Template.roleAssignmentThemeView.events
    'change .userRoleAssignment':(e)->
      Meteor.call('updateUserRole',this._id,$(e.currentTarget).val(),(err,res)->
        if res
          createNotification("Role is assigned",1)
      )
