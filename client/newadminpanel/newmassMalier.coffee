Template.systemNotificationsnew.rendered = ->
  ukey = this.data.ukey
  Meteor.subscribe('notifications',ukey)
Template.systemNotificationsnew.helpers
  notifications:()->
    notifications.find().fetch()
Template.systemNotificationsnew.events
  'click .delete-notification':(e)->
    notifications.remove({_id:this._id})
  'click .deactivate-notification':(e)->
    notifications.update({_id:this._id},{$set:{active:false}})
  'click .activate-notification':(e)->
    notifications.update({_id:this._id},{$set:{active:true}})

Template.massMailerFormNew.rendered = ->
  $("#emailBody"). summernote()
Template.massMailerFormNew.events
  'click .send-mass-mail':(e)->
      Meteor.call('sendMassMail',platforms.findOne()._id,$('#emailSubject').val(),$('#emailBody').code())
      e.preventDefault()

Template.individualMailerNew.events
  'click .send-individual-mail':(e)->
      emailIds = $('#usersemails').val()
      Meteor.call('sendMultipleMail',platforms.findOne()._id,emailIds,$('#emailSubjectIndi').val(),$('#emailBodyIndi').code())
      e.preventDefault()


Template.individualMailerNew.rendered = ->
  $("#emailBodyIndi").summernote()

Template.individualMailerNew.helpers
  userEmails:()->
    emails = []

    for u in Meteor.users.find().fetch()
      emails.push {e:decodeEmail(u.personal_profile.email)}
    emails
