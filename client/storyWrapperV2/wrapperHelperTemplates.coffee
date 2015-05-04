# Template.fullVirtualTourModal.events
#  'click .next-help-btn':(e)->
#    $('.first-btn').addClass('second-btn').removeClass('first-btn')
#    $('.help-content-container').empty()
#    eattr = $(e.currentTarget).attr('next-screen')
#    console.log eattr
#    for t in virtualTour[eattr].textPoints
#      $('.help-content-container').append(t.textValue)
#
#    $('.help-content-container').append('<div class="row text-center vpadded-row ">
#               <div class="col-sm-1 col-sm-offset-8" style="padding: 0">
#                        <a href="#" id="nxt-btn" class="'+virtualTour[eattr]['btnValue']['classVal']+'">'+virtualTour[eattr]['btnValue']['name']+'</a>
#                    </div>
#
#              </div> ')



Template.wrapperSideBar.rendered = ->
    $('.side-bar-link').popover({trigger:'hover',html: true,delay: { "show": 500, "hide": 100 }})


Template.wrapperSideBar.events
  'click .notification-link':(e)->
    showModal('notificationModal',{},'main-wrapper-page')
    setTimeout(()->
      markAllNotiRead(Meteor.userId())
    ,2000)

  'click .document-link':(e)->
    showModal('documentModal',{},'main-wrapper-page')
  'click .reward-link':(e)->
    showModal('rewardModal',{},'main-wrapper-page')

  'click .badge-link':(e)->
    showModal('badgeModal',{},'main-wrapper-page')

  'click .user-profile-link':(e)->
    showModal('userProfileModal',{},'main-wrapper-page')
  'click .leader-board-link':(e)->
    showModal('leaderBoardModal',{},'main-wrapper-page')
  'click .feedback-link':(e)->
    showModal('feedbackModal',{},'main-wrapper-page')
  'click .contact-us-link':(e)->
    showModal('contactusModal',{},'main-wrapper-page')
  'click .vt-link':(e)->
    $('.modal-backdrop').remove()
    showModal('virtualTourModal',{},'main-wrapper-page')


  'click .sign-out-link' :(e)->
    Meteor.logout()



Template.notificationModal.helpers
  notiPassKey:()->
    {ukey:platforms.findOne()._id}



Template.feedbackModal.events
  'submit form':(e)->
    u = Meteor.userId()
    p = platforms.findOne()._id
    s = $(e.currentTarget).find('#user-feedback').val()
    plaformUserFeedbacks.insert({platformId:p,from:u,feedback:s})
    $('.remove-modal').trigger('click')
    e.preventDefault()

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
#    if document.getElementById('cover-pic').files.length isnt 0
#      coverPic = new FS.File(document.getElementById('cover-pic').files[0])
#      coverPic.owner = Meteor.userId()
#      coverPic.stored = false
#      cp = assetFiles.insert(coverPic)
#      cpid = cp._id
#    else
#      cpid = Meteor.user().personal_profile.coverPicId
    cpid = -1
    if $('#user-password-old').val().length isnt 0
      Accounts.changePassword($('#user-password-old').val(),$('#user-password-new').val(),(err)->
        if err?
          createNotification(err.message,1)
      )
    $('#overlay').show()
    Tracker.autorun(()->

      if assetFiles.findOne(ppid).stored
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

    $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"})

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


          deckList.push {flag:flag,deckId:d,deckDesc:deckHtml.findOne({deckId:d}).desc,deckName:deckHtml.findOne({deckId:d}).name,status:status,deckPic:deckHtml.findOne({deckId:d}).pic}
          if status is 'incomplete' and i is 0
            flag = 'none'
      deckList


Template.chatWrapper.events
  'click .chat-contact':(e)->
    parent = $(e.currentTarget).find('.media').attr('href')
    $(e.currentTarget).parents(parent).toggleClass('oc-lg-hidden-right  oc-lg-open-right')

  'click .chat-close':(e)->
    parent = $(e.currentTarget).attr('href')
    $(e.currentTarget).parents(parent).toggleClass('oc-lg-hidden-right  oc-lg-open-right')
    e.stopPropagation()


Template.chatWrapper.rendered = ->
  $('[rel=switch]').each ->
    $this = undefined
    iswitch = undefined
    $this = $(this)
    iswitch = new Switch(this)
    if !($this.attr('readonly') or $this.attr('disabled'))
      return $(iswitch.el).on('click', (e) ->
        e.preventDefault()
        iswitch.toggle()
      )
    return


Template.virtualTourModal.events
  'click #vt-badges': (e) ->
    console.log "badges"
    $(".badge-link")[0].click()
    $('#badgesModal .modal-body').virtualTour(window.badgesVTO)

  'click #vt-notification': (e) ->
    console.log "notification"
    $(".notification-link")[0].click()
    $('#notificationsModal .modal-body').virtualTour(window.notificationsVTO)

  'click #vt-reward': (e) ->
    console.log "reward"
    $(".reward-link")[0].click()
    $('#rewardsModal .modal-body').virtualTour(window.rewardsVTO)

  'click #vt-document': (e) ->
    console.log "document"
    $(".document-link")[0].click()
    setTimeout(->
      $('#documentsModal .modal-body').virtualTour(window.documentsVTO)
    , 100)

  'click #vt-leaderboard': (e) ->
    console.log "leader"
    $(".leader-board-link")[0].click()
    setTimeout(->
      $('#leaderboardModal .modal-body').virtualTour(window.leaderboardVTO)
    , 100)

  'click #vt-chat' : (e) ->
    console.log "cheat"
    $('#jump-to-menu .close').click()
    $("#oc-right-toggle").click()
    setTimeout(->
      $('#main-wrapper-page').virtualTour(window.chatVTO)
    , 100)

    # ...
