if Meteor.isClient
  @markAllNotiRead = (uid)->
    Meteor.users.update({_id:uid},{$set:{unreadNoti:0}})

  UI.registerHelper "getUnreadNoti", ()->

    Meteor.user().unreadNoti


  Template.massMailerForm.rendered = ->
    $("#emailBody"). summernote()
  Template.massMailerForm.events
    'click .send-mass-mail':(e)->
        Meteor.call('sendMassMail',platforms.findOne()._id,$('#emailSubject').val(),$('#emailBody').code())
        e.preventDefault()


  Template.individualMailer.events
    'click .send-individual-mail':(e)->
        emailIds = $('#usersemails').val()
        Meteor.call('sendMultipleMail',platforms.findOne()._id,emailIds,$('#emailSubjectIndi').val(),$('#emailBodyIndi').code())
        e.preventDefault()


  Template.individualMailer.rendered = ->
    $("#emailBodyIndi").summernote()
  Template.newNotification.helpers
    userEmails:()->
      emails = []

      for u in Meteor.users.find().fetch()
        emails.push {_id:u._id,e:decodeEmail(u.personal_profile.email)}
      emails
  Template.individualMailer.helpers
    userEmails:()->
      emails = []

      for u in Meteor.users.find().fetch()
        emails.push {e:decodeEmail(u.personal_profile.email)}
      emails

  Template.newNotification.rendered = ->
    Session.set("uniKeyForNoti",this.data.ukey)
    setTimeout(()->
      $('#usersemails2').chosen({width:'100%'})
    ,500)

  Template.newNotification.events
    'click .create-notification':(e)->
      notiMsg = $("#notificationMessage").val()
      notiTarget = $("#usersemails2").val()
      for u in notiTarget
        createUserNotification(u,Session.get("uniKeyForNoti"),notiMsg)


#      createUserNotification()
#      notifications.insert({message:notiMsg,createdAt:new Date().getTime(),active:true,uid:Session.get("uniKeyForNoti")})

  Template.systemNotifications.rendered = ->
    ukey = this.data.ukey
    Meteor.subscribe('notifications',ukey)
  Template.systemNotifications.helpers
    notifications:()->
      notifications.find().fetch()
  Template.systemNotifications.events
    'click .delete-notification':(e)->
      notifications.remove({_id:this._id})
    'click .deactivate-notification':(e)->
      notifications.update({_id:this._id},{$set:{active:false}})
    'click .activate-notification':(e)->
      notifications.update({_id:this._id},{$set:{active:true}})


  Template.plainNotificationList.rendered = ->

      ukey = this.data.ukey
      console.log ukey
      console.log "plain noti"
      Meteor.subscribe('userNotifications',ukey,Meteor.userId())
#      $('.list-group-item').splice(0,Meteor.user().unreadNoti).addClass('active')
  Template.plainNotificationList.helpers
    unreadnotifications:()->
      _.sortBy(notifications.find().fetch(),'createdAt').reverse().splice(0,Meteor.user().unreadNoti)
    readnotifications:()->
      _.sortBy(notifications.find().fetch(),'createdAt').reverse().splice(Meteor.user().unreadNoti,notifications.find().fetch().length)
