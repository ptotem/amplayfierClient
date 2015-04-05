if Meteor.isServer

  @sendEmails = (emailList,subject,body)->
    NigerianPrinceGun = new Mailgun(mailgunoptions);

    for e in emailList
        NigerianPrinceGun.send
          'to': e
          'from': mailgunoptions.defaultFrom
          'html': body
          'text': 'someText'
          'subject': subject



  Meteor.methods
    sendMassMail: (pid, subject, body) ->

      ul = Meteor.users.find('personal_profile.platform': pid.toString()).fetch()
      emailIds = []
      i = 0
      while i < ul.length
        emailIds.push decodeEmail(ul[i].personal_profile.email)
        i++
      sendEmails emailIds, subject, body
      return
    sendMultipleMail: (pid, emailIds, subject, body) ->
      emailList = []
      ul = emailIds
      i = 0
      while i < ul.length
        emailList.push decodeEmail(ul[i])
        i++
      sendEmails emailList, subject, body
      return
  Meteor.publish('notifications',(pid)->
    notifications.find({uid:pid})
  )

  Meteor.publish('userNotifications',(pid,usrid)->
    notifications.find({$or:[{uid:pid,userId:"-1"},{uid:pid,userId:usrid}]})
  )