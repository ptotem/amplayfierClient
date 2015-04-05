@createUserNotification = (userid,unikey,notiMessage)->
  notifications.insert({message:notiMessage,createdAt:new Date().getTime(),active:true,uid:unikey,userId:userid})


@notifications = new Meteor.Collection('notifications');
@notifications.allow
  insert:(userId, role) ->

    if role.userId is -1
     for u in Meteor.users.find().fetch()
        Meteor.users.update({_id:u._id},{$inc:{unreadNoti:1}})
    else
      Meteor.users.update({_id:userId},{$inc:{unreadNoti:1}})

    true
  update:(userId, doc, fieldNames, modifier)->

    true
  remove:(userId, doc)->
    true




