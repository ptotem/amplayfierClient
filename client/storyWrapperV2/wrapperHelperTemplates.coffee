Template.wrapperSideBar.rendered = ->
    $('.side-bar-link').popover({trigger:'hover',html: true,delay: { "show": 500, "hide": 100 }})


Template.wrapperSideBar.events
  'click .notification-link':(e)->
    showModal('notificationModal',{},'main-wrapper-page')
  'click .document-link':(e)->
    showModal('documentModal',{},'main-wrapper-page')
  'click .reward-link':(e)->
    showModal('rewardModal',{},'main-wrapper-page')

  'click .badge-link':(e)->
    showModal('badgeModal',{},'main-wrapper-page')

  'click .user-profile-link':(e)->
    showModal('userProfileModal',{},'main-wrapper-page')

  'click .sign-out-link' :(e)->
    Meteor.logout() 



Template.notificationModal.helpers
  notiPassKey:()->
    {ukey:platforms.findOne()._id}


Template.rewardModal.helpers
  rewards:()->
    systemRewards.find().fetch()
Template.badgeModal.helpers
  sysBadges1:()->
   userBadgeNames = _.pluck(Meteor.user().badges,'name')
   finalBadges = []
   for s in systemBadges.find({}).fetch()[0..4]
     if userBadgeNames.indexOf(s.name) isnt -1
       imgp = s.imgPath.replace("-bw","")
       s['imgPath'] = imgp
     finalBadges.push s
   finalBadges
  sysBadges2:()->
    userBadgeNames = _.pluck(Meteor.user().badges,'name')
    finalBadges = []
    for s in systemBadges.find({}).fetch()[5..9]
      if userBadgeNames.indexOf(s.name) isnt -1
        imgp = s.imgPath.replace("-bw","")
        s['imgPath'] = imgp
      finalBadges.push s
    finalBadges



Template.userProfileModal.events
  'click .update-user':(e)->
    display_name = $("#user-name").val()
    first_name = $("#user-first-name").val()
    last_name = $("#user-last-name").val()
    designation = $("#user-designation").val()
    if document.getElementById('profile-pic').files.length isnt 0
      profilePic = new FS.File(document.getElementById('profile-pic').files[0])
      profilePic.owner = Meteor.userId()
      profilePic.stored = false
      pp = assetFiles.insert(profilePic)
      ppid = pp._id
    else
      ppid = Meteor.user().personal_profile.profilePicId
    if document.getElementById('cover-pic').files.length isnt 0
      coverPic = new FS.File(document.getElementById('cover-pic').files[0])
      coverPic.owner = Meteor.userId()
      coverPic.stored = false
      cp = assetFiles.insert(coverPic)
      cpid = cp._id
    else
      cpid = Meteor.user().personal_profile.coverPicId
    if $('#user-password-old').val().length isnt 0
      Accounts.changePassword($('#user-password-old').val(),$('#user-password-new').val(),(err)->
        if err?
          createNotification(err.message,1)
      )
    $('#overlay').show()
    Tracker.autorun(()->
      console.log assetFiles.findOne(ppid).stored
      if assetFiles.findOne(ppid).stored and assetFiles.findOne(cpid).stored
        pp = Meteor.user().personal_profile
        pp['coverPicId'] = cpid
        pp['profilePicId'] = ppid
        pp['first_name'] = first_name
        pp['last_name'] = last_name
        pp['display_name'] = display_name
        pp['designation'] = designation

        Meteor.users.update({_id:Meteor.userId()},{$set:{personal_profile:pp}})
        $('.modal').modal('hide')
        $('.user-edit-form').remove()
        $('#overlay').hide()


    )



Template.mainWrapper.events
  'click .remove-modal':(e)->

    $('.modal').modal('hide')
    $('.modal').remove()

Template.badgeModal.rendered = ->
  $($('.badge-item')[0]).addClass('col-md-offset-1')
  $($('.badge-item')[5]).addClass('col-md-offset-1')

Template.nodeTemp.helpers
  deckOfNode:(s)->
    if s?
      deckList = []

      flag = 'auto'

      if platforms.findOne().nodes[s].decks?
        for d,i in platforms.findOne().nodes[s].decks
          if userCompletions.findOne({userId:Meteor.userId(),deckId:d})?
            status = 'complete'
          else
            status = 'incomplete'


          deckList.push {flag:flag,deckId:d,deckName:deckHtml.findOne({deckId:d}).name,status:status}
          if status is 'incomplete' and i is 0
            flag = 'none'
      deckList

  deckDesc:()->
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
