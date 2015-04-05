@roles = new Meteor.Collection('myroles')
@capabilities = new Meteor.Collection('capabilities')
#Meteor.startup ()->
#  if Meteor.isServer
#    if roles.find().fetch().length is 0
#      console.log roles.find().fetch().length
#      roles.remove({rolename:"superadmin"})
#      roles.insert({rolename:'superadmin',roledesc:'This is the super admin role'})

@roles.allow
  insert:(userId, role) ->
    roles.findOne(Meteor.users.findOne(userId).personal_profile.role).capabilities.indexOf('add_roles') isnt -1
  update:(userId, doc, fieldNames, modifier)->

    roles.findOne(Meteor.users.findOne(userId).personal_profile.role).capabilities.indexOf('update_roles') isnt -1
    true
  remove:(userId, doc)->
    roles.findOne(Meteor.users.findOne(userId).personal_profile.role).capabilities.indexOf('delete_roles') isnt -1




@addRoles = (name,desc,capabilityMatrix,uk)->

  roles.insert({rolename:name,roledesc:desc,capabilities:capabilityMatrix,unikey:uk})
