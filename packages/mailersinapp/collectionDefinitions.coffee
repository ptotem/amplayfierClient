@notifications = new Meteor.Collection('notifications');
@notifications.allow
  insert:(userId, role) ->
    for u in Meteor.users.find().fetch()
      Meteor.users.update({_id:u._id},{$inc:{unreadNoti:1}})
    true
  update:(userId, doc, fieldNames, modifier)->

    true
  remove:(userId, doc)->
    true




