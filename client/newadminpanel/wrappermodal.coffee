Template.addvariantModal.events
  'click .remove-modal': (e) ->
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"} )
    $(".modal-backdrop").hide();

  'click .add-individual-variant': (e) ->
    arr = []
    $('.userDecks').each (i, v) ->
      #console.log $(v).find('.deckname').val()
      a = {}
      a[$(v).find('.deckname').val()] = $(v).find('.variant-chosen').val()
      arr.push a
      return
    platId = platforms.findOne()._id
    profile = {name: $('#currentProfileName').val(), description: $('#currentProfileDesc').val() }
    platforms.update({_id: platId} , {$pull: {profiles: profile} } )
    profile.variants = arr
    platforms.update({_id: platId} , {$push: {profiles: profile} } )
    console.log platforms.findOne({_id: platId} ).profile
    createNotification("Variants are added to this profile", 1)
    $('.remove-modal').click()

Template.addvariantModal.helpers
  userDeckHtml: () ->
    deckHtml.find().fetch()

  deckVariants: (deckId) ->
    variants = []
    deck = deckHtml.findOne(deckId)
    if deck.variants?
      for j in deck.variants
        variants.push({userVariants: j} )
    variants

Template.topBarModal.events
  'click .remove-modal': (e) ->
    console.log("clicked") ;
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"} )
    $(".modal-backdrop").hide();

  'click .manage-user': (e) ->
    $("#left-menu-container").empty();
    Blaze.renderWithData(Template['profilesLeftMenu'],{},document.getElementById('left-menu-container'))
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"} )

  'click .manage-report': (e) ->
    $("#left-menu-container").empty();
    Blaze.renderWithData(Template['manageReport'],{},document.getElementById('left-menu-container'))
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"} )

  'click .mailers': (e) ->
    $("#left-menu-container").empty();
    Blaze.renderWithData(Template['portalMailer'],{},document.getElementById('left-menu-container'))
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"} )

  'click .repository': (e) ->
    $("#left-menu-container").empty();
    Blaze.renderWithData(Template['repository'],{},document.getElementById('left-menu-container'))
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"} )

  'click .roles': (e) ->
    $("#left-menu-container").empty();
    Blaze.renderWithData(Template['rolesLeftMenu'],{},document.getElementById('left-menu-container'))
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"} )

  'click .rewards': (e) ->
    $("#left-menu-container").empty();
    Blaze.renderWithData(Template['rewardsLeftMenu'],{},document.getElementById('left-menu-container'))
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"} )

  'click .badges': (e) ->
    $("#left-menu-container").empty();
    Blaze.renderWithData(Template['badgesLeftMenu'],{},document.getElementById('left-menu-container'))
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"} )

  'click .enrollment': (e) ->
    $("#left-menu-container").empty();
    Blaze.renderWithData(Template['enrollmentsLeftMenu'],{},document.getElementById('left-menu-container'))
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"} )

  'click .assesment': (e) ->
    $("#left-menu-container").empty();
    Blaze.renderWithData(Template['assessmentsLeftMenu'],{},document.getElementById('left-menu-container'))
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"} )


Template.addprofileModal.events
  'click .remove-modal': (e) ->
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"} )
    $(".modal-backdrop").hide();

  'click .add-individual-profile': (e) ->
    profile = {name: $("#profile-name").val(), description: $("#profile-desc").val() }
    platId = platforms.findOne()._id
    platforms.update({_id: platId} , {$push: {profiles: profile} } )
    createNotification("Profile has been added successfully", 1)
    $(".internal-sidelinks.active").trigger('click')
    $('.remove-modal').click()


Template.adduserModal.events
  'click .remove-modal': (e) ->
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"} )
    $(".modal-backdrop").hide();

  'click .add-individual-user': (e) ->
    email = $("#user-email").val()
    newemail = encodeEmail(email, platformName)

    display_name = $("#user-name").val()
    first_name = $("#user-first-name").val()
    last_name = $("#user-last-name").val()
    reportingTo = $(".reporting-mgr").val()
    hrManagerTo = $(".hr-mgr").val()
    role = $('.user-role').val()
    currUserFname = Meteor.users.findOne({_id: Meteor.userId() } ).personal_profile.first_name
    currUserLname = Meteor.users.findOne({_id: Meteor.userId() } ).personal_profile.last_name

    pid = platforms.findOne()._id

    p = {platform: pid, first_name: first_name, last_name: last_name, display_name: display_name, email: newemail, reportingManager: reportingTo, role: role, hrmanager: hrManagerTo}

    if $("#user-id").val() == ''
      Meteor.call("addIndividualUser", p, pid, (err, res) ->


        if err?
          createNotification(err.message, 0)
        else
          if !res
            createNotification('User Limit reached', 0)

          else
            Meteor.call("sendUserAddMailGunMail", email, first_name, last_name, currUserFname, currUserLname)
            createNotification("User successfully added", 1)

      )

    else
      p = Meteor.users.findOne($("#user-id").val()).personal_profile

      p['platform'] = pid
      p['first_name'] = first_name
      p['last_name'] = last_name
      p['display_name'] = display_name
      p['reportingManager'] = reportingTo
      p['role'] = role
      p['hrmanager'] = hrManagerTo
      console.log hrManagerTo
      Meteor.call('updateUser', $("#user-id").val(), p)
      Meteor.call("sendUserAddMailGunMail", email, first_name, last_name, currUserFname, currUserLname)
      createNotification('Profile has been updated', 1)
      $('.remove-modal').click()

Template.newNoti.events
  'click .remove-modal': (e) ->
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"} )
    $(".modal-backdrop").hide();


Template.newNoti.helpers
  userEmails: () ->
    emails = []

    for u in Meteor.users.find().fetch()
      emails.push {_id: u._id, e: decodeEmail(u.personal_profile.email) }
    emails

Template.newNoti.rendered = ->
  Session.set("uniKeyForNoti", this.data.ukey)
  setTimeout(() ->
    $('#usersemails2').chosen({width:'100%'} )
  , 500)

Template.newNoti.events
  'click .create-notification': (e) ->
    notiMsg = $("#notificationMessage").val()
    notiTarget = $("#usersemails2").val()
    for u in notiTarget
      createUserNotification(u, Session.get("uniKeyForNoti"), notiMsg)
    $('.remove-modal').click()


Template.adduserModal.helpers
  myusers: () ->
    Meteor.users.find().fetch()
  myuser: (uid) ->
    if uid isnt - 1
      Meteor.users.findOne(uid)
    else
      {}
  roles: () ->
    roles.find().fetch()

Template.newAssessmentModal.events
  'click .remove-modal': (e) ->
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"} )
    $(".modal-backdrop").hide();

  'click .new-assessment-for-admin-save': (e) ->
    newassessment = $("#new-assessment").val()
    assesments.insert({assessmentName: newassessment, platform: platforms.findOne()._id} )
    $('.remove-modal').click()

#  'shown.bs.modal .modal': (e)->
#    console.log "modal shown"
#
#  'hidden.bs.modal .modal': (e)->
#    console.log "modal hidden"


Template.newQuestionForAssessmentModal.events
  'click .remove-modal': (e) ->
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"} )
    $(".modal-backdrop").hide();

  'click .new-question-for-admin-save': (e) ->
    nqName = $("#new-question-name").val()
    nqMax = $("#new-question-max").val()
    nqMin = $("#new-question-min").val()
    manualData = {statement: nqName, min: nqMin, max: nqMax}
    assesments.update({_id: Session.get("newquesId") } , {$push: {scoreQuestions: manualData} } )
    # assesments.update({statement:nqName,min:nqMin,max:nqMax,platform:platforms.findOne()._id,_id:assesments.findOne()._id})
    $('.remove-modal').click()

Template.viewQuestionsForAssessmentModal.events
  'click .remove-modal': (e) ->
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"} )
    $(".modal-backdrop").hide();

Template.viewQuestionsForAssessmentModal.helpers
  viewQuestion: () ->
    assesments.findOne(Session.get("viewquesId")).scoreQuestions

# Template.editUsers.events
#   'click .remove-modal': (e) ->
#     $('.modal').modal('hide')
#     $('.modal').remove()
#     $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"} )

Template.newRewardModal.events
  'click .remove-modal': (e) ->
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"} )
    $(".modal-backdrop").hide();

  'click .new-reward-save': (e) ->
    if document.getElementById('new-reward-file').files.length is 0
      createNotification("Please upload a reward image", 1)
    else
      rewardFile = new FS.File(document.getElementById('new-reward-file').files[0])
      rewardFile.platform = platforms.findOne()._id
      rewardFile.stored = false
      rewardName = $("#new-reward-name").val()
      rewardDesc = $("#new-reward-desc").val()
      rewardVal = $("#new-reward-value").val()
      rewardStock = $("#new-reward-stock").val()

      $("#overlay").show()
      rf = assetFiles.insert(rewardFile)
      rfid = rf._id
      Tracker.autorun(() ->
        console.log assetFiles.findOne(rfid).stored
        if assetFiles.findOne(rfid).stored
          systemRewards.insert({stock: rewardStock, name: rewardName, description: rewardDesc, value: rewardVal, rewardImage: rfid, pid: platforms.findOne()._id} )
          $("#overlay").hide()

      )
    $('.remove-modal').click()

Template.newRoleModal.events
  'click .remove-modal': (e) ->
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"} )
    $(".modal-backdrop").hide();

Template.assignRoleModal.events
  'click .remove-modal': (e) ->
    $('.modal').modal('hide')
    $('.modal').remove()
    $('.modal-blur-content').css({"-webkit-filter": "blur(0px)"} )
    $(".modal-backdrop").hide();
