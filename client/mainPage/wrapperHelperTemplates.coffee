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
    $('.side-bar-link').popover({trigger:'hover',html: true,delay: { "show": 500, "hide": 5 }})
    $('.side-bar-image').popover({trigger:'hover',html: true,delay: { "show": 500, "hide": 5 }})


Template.wrapperSideBar.helpers
  isEnabled:(k)->
    console.log platforms.findOne()[k]
    platforms.findOne()[k]
  platformStatus:()->
    platforms.findOne().platformStatus

  menuEnabled:()->
    Session.get('subPlatformMenuBar')

  isGuestUser:()->
    if Meteor.users.findOne({_id:Meteor.userId()})?
      if Meteor.users.findOne({_id:Meteor.userId()}).personal_profile.email.indexOf("@temp.com") isnt -1
        true
      else
        false


  sidebarForTata:()->
    if platforms.findOne().wrapperJson.specific
      "true"
    else
      if platforms.findOne().wrapperJson.isModal
        "true"
      else
        "false"           

  isSpecific:()->
    platforms.findOne().wrapperJson.specific
  ismodal:()->
    platforms.findOne().wrapperJson.isModal

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
  'click .companyHealth-link':(e)->
    showModal('companyHealthModal',{},'main-wrapper-page')
  'click .feedback-link':(e)->
    showModal('feedbackModal',{},'main-wrapper-page')
  'click .contact-us-link':(e)->
    showModal('contactusModal',{},'main-wrapper-page')
  'click .login-link':(e)->
    showModal('modalLogin',{},'main-wrapper-page')
  'click .vt-link':(e)->
    $('.modal-backdrop').remove()
    showModal('virtualTourModal',{},'main-wrapper-page')


  'click .sign-out-link' :(e)->
    Meteor.logout()

  'click .master-home':(e)->
    window.location = "/"

  'click .help-modal':(e)->
    showModal('tataModal',{},'main-wrapper-page')


Template.notificationModal.helpers
  notiPassKey:()->
    {ukey:platforms.findOne()._id}

Template.notificationModal.events
  'click .remove-modal':(e)->

    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-wrap').remove()

    $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"})

Template.contactusModal.events
  'click .remove-modal':(e)->

    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-wrap').remove()

    $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"})

Template.leaderBoardModal.events
  'click .remove-modal':(e)->

    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-wrap').remove()

    $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"})

Template.badgeModal.events
  'click .remove-modal':(e)->

    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-wrap').remove()

    $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"})

Template.rewardModal.events
  'click .remove-modal':(e)->

    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-wrap').remove()

    $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"})


Template.feedbackModal.events
  'submit form':(e)->
    u = Meteor.userId()
    p = platforms.findOne()._id
    s = $(e.currentTarget).find('#user-feedback').val()
    plaformUserFeedbacks.insert({platformId:p,from:u,feedback:s})
    $('.remove-modal').trigger('click')
    e.preventDefault()

  'click .remove-modal':(e)->

    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-wrap').remove()

    $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"})

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
  'click .remove-modal':(e)->

    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-wrap').remove()

    $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"})

  'click .update-user':(e)->
    display_name = $("#user-name").val()
    first_name = $("#user-first-name").val()
    last_name = $("#user-last-name").val()
    designation = $("#user-designation").val()

    # if document.getElementById('profile-pic').files.length isnt 0
    #   profilePic = new FS.File(document.getElementById('profile-pic').files[0])
    #   profilePic.owner = Meteor.userId()
    #   profilePic.stored = false
    #   pp = assetFiles.insert(profilePic)
    #   ppid = pp._id
    # else
    #   ppid = Meteor.user().personal_profile.profilePicId



#    if document.getElementById('cover-pic').files.length isnt 0
#      coverPic = new FS.File(document.getElementById('cover-pic').files[0])
#      coverPic.owner = Meteor.userId()
#      coverPic.stored = false
#      cp = assetFiles.insert(coverPic)
#      cpid = cp._id
#    else
#      cpid = Meteor.user().personal_profile.coverPicId
    # cpid = -1
    if $('#user-password-old').val().length isnt 0
      Accounts.changePassword($('#user-password-old').val(),$('#user-password-new').val(),(err)->
        if err?
          createNotification(err.message,1)
      )
    $('#overlay').show()
    Tracker.autorun(()->

      # if assetFiles.findOne(ppid).stored
        pp = Meteor.user().personal_profile
        # pp['coverPicId'] = cpid
        # pp['profilePicId'] = ppid
        pp['first_name'] = first_name
        pp['last_name'] = last_name
        pp['display_name'] = display_name
        pp['designation'] = designation

        Meteor.users.update({_id:Meteor.userId()},{$set:{personal_profile:pp}})

        $('.modal').modal('hide')
        $('.user-edit-form').remove()
        $('#overlay').hide()


    )
    createNotification("Profile updated successfully",1)
    # setTimeout(()->
    #   location.reload()
    # ,500)




Template.mainWrapper.events
  'click .remove-modal':(e)->

    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-wrap').remove()

    $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"})

Template.badgeModal.rendered = ->
  $($('.badge-item')[0]).addClass('col-sm-offset-1')
  $($('.badge-item')[5]).addClass('col-sm-offset-1')
  $('.badge-item').each((ind,ele)->
    if ind isnt 0 and ind isnt 5
      $(ele).css("margin-left","0px")
  )
Template.nodeTemp.rendered = () ->

  console.log this
  n = _.where(platforms.findOne().nodes,{sequence:this.data.seq})[0].decks.length
  pinCols = if n > 2 then 3 else n
  if window.innerHeight > window.innerWidth
    n = 2
  else
    setTimeout(()->
      $('#pinBoot').pinterest_grid
        no_columns: pinCols
        padding_x: 10
        padding_y: 10
        margin_bottom: 50
        single_column_breakpoint: 700
    ,500)


Template.nodeTemp.helpers

  pintrestApplied:()->
    console.log window.innerHeight < window.innerWidth
    window.innerHeight < window.innerWidth

  deckOfNode:(s)->
    if s?
      deckList = []

      flag = 'auto'
      n = _.where(platforms.findOne().nodes,{sequence:s})[0]
      if n.decks?
        for d,i in n.decks
          if userCompletions.findOne({userId:Meteor.userId(),deckId:d})?
            status = 'complete'
          else
            status = 'incomplete'


          deckList.push {seq:s,flag:flag,deckId:d,deckDesc:deckHtml.findOne({deckId:d}).desc,deckName:deckHtml.findOne({deckId:d}).name,status:status,deckPic:deckHtml.findOne({deckId:d}).pic}
          if status is 'incomplete' and i is 0
            flag = 'none'

      deckList

  deckCountGreaterThan:(count, s)->
    n = _.where(platforms.findOne().nodes,{sequence:s})[0]
    n.decks.length > count

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

Template.virtualTourModal.helpers
  isEnabled:(k)->
    console.log platforms.findOne()[k]
    platforms.findOne()[k]

Template.virtualTourModal.events

  'click #vt-badges': (e) ->
    console.log "badges"
    $(".badge-link")[0].click()
    setTimeout(->
      $('#badgesModal .modal-body').virtualTour(window.badgesVTO)
    , 100)

  'click #vt-notification': (e) ->
    console.log "notification"
    $(".notification-link")[0].click()
    setTimeout(->
      $('#notificationsModal .modal-body').virtualTour(window.notificationsVTO)
    , 100)

  'click #vt-reward': (e) ->
    console.log "reward"
    $(".reward-link")[0].click()
    setTimeout(->
      $('#rewardsModal .modal-body').virtualTour(window.rewardsVTO)
    , 100)

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
      $('.modal-body').virtualTour(window.leaderboardVTO)
    , 100)

  'click #vt-chat' : (e) ->
    console.log "cheat"
    $('#jump-to-menu .close').click()
    $("#oc-right-toggle").click()
    setTimeout(->
      $('#main-wrapper-page').virtualTour(window.chatVTO)
    , 100)

  'click .remove-modal':(e)->

    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-wrap').remove()

    $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"})

    # ...

Template.modalLogin.events
  'submit #storyLoginForm':(e)->
    pn = platformName
    userEmail = $(e.currentTarget).find("#email").val().toString()
    newEmail = encodeEmail(userEmail,pn)
    userPassword = $(e.currentTarget).find("#password").val()
    authenticatePassword(newEmail,userPassword,"/")
    false

  'click .remove-modal':(e)->

    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-wrap').remove()

    $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"})

Template.leaderBoardModal.helpers
  mainLeaderboard:()->
    if ampQuoScore.findOne()? and ampQuoScore.findOne().results?
      gameData = getGameParams(platforms.findOne().gameName)
      basescore = _.where(gameData, {name: "Topline (Rs. Cr.)"})[0].baseSCore
      myScore = {}
      if _.where(ampQuoScore.findOne({}).results,{name: "Topline (Rs. Cr.)"}).length > 0
        scores =  _.where(ampQuoScore.findOne({}).results,{name: "Topline (Rs. Cr.)"})[0].data
        totalScore = []
        
        for i in scores
          if Meteor.users.findOne({_id:i.userid})?
            if Meteor.users.findOne({_id:i.userid}).personal_profile?
              i.username = Meteor.users.findOne({_id:i.userid}).personal_profile.fullname
            else
              i.username = Meteor.users.findOne({_id:i.userid}).personal_profile.email

          if i.totalScore? and i.totalScore < basescore
            i.score = Math.round(i.totalScore - 0.03*i.totalScore)
          else
            i.score = Math.round(i.totalScore)

          if i.userid is Meteor.userId()
            myScore = i
          if !isNaN(i.score)
            totalScore.push i
      totalScore = _.sortBy(totalScore, 'score')
      totalScore = totalScore.reverse()
      totalScore = _.map(totalScore, (val, index)->
                    val.index = index + 1
                    if val.quoScores.length > 2
                      if val.quoScores[(val.quoScores.length-1)] < val.quoScores[(val.quoScores.length-2)]
                        val.classes = "/assets/images/arrowDown.png" 
                      else
                        val.classes = "/assets/images/arrowUp.png"
                    else
                      val.classes = "/assets/images/arrowUp.png"
                    val
                  )
      totalScore = totalScore[0..4]
      setMyScore(myScore)
      totalScore

  userScore:()->
    a = getMyScore()
    a

@setMyScore = (myScore)->
  @myScore = myScore

@getMyScore = (myScore)->
  @myScore

