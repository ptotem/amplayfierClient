Template.adminHeaderBar.events
  'click .enterprise-chat':(e)->
    showModal('enterpriseOnly',{},'main-wrapper-page-new')
  'click .logout-link': (e) ->
    Meteor.logout()

  'click .dropdown': (e) ->
    if $(e.currentTarget).hasClass('open')
      $(e.currentTarget).removeClass('open')
    else
      $(e.currentTarget).addClass('open')

Template.adminHeaderBar.helpers
  unreadMessages: () ->
    messageCount = messages.find({to: Meteor.userId(), unread: true} ).fetch().length
    messageCount

Template.adminHeaderBar.rendered = () ->
  Meteor.call('updateUserChatFalse', Meteor.userId())


Template.rewardsLeftMenu.helpers
  rewards:()->
    systemRewards.find().fetch()
  getRewardStatus:()->
    platforms.findOne()['rewards']

Template.userlistLeftMenu.rendered = ->
  if platforms.findOne()['platformStatus'] is 'close'
    $(".onoffswitch-checkbox").prop("checked", false);
  else
    $(".onoffswitch-checkbox").prop("checked", true);

Template.repository.rendered = ->
  if platforms.findOne()['repository']
    $(".onoffswitch-checkbox").prop("checked", true);
  else
    $(".onoffswitch-checkbox").prop("checked", false);
Template.repository.helpers

  getRepoStatus:()->
      platforms.findOne()['repository']


Template.rolesLeftMenu.helpers
  setUniqKey:()->
    {uniqKey:platforms.findOne()._id}
  myusers: () ->
    Meteor.users.find().fetch()
  roles:()->
    roles.find().fetch()

Template.profilesLeftMenu.helpers
  getPlatformProfiles: (uid)->
    dep.depend()
    profiles = []
    if platforms.findOne().profiles?
      for p in platforms.findOne().profiles
        p["uid"] = uid
        profiles.push p

    profiles

Template.badgesLeftMenu.helpers
  processBadgeImage:(ipath)->
    ipath.replace("-bw","")
  bottombadges:()->
    platforms.findOne().badges
  topbadges:()->
    platforms.findOne().badges

  getBadgeStatus:()->
    platforms.findOne()['badgesStatus']

Template.badgesLeftMenu.rendered = ->
  if platforms.findOne()['badgesStatus']
    $(".onoffswitch-checkbox").prop("checked", true);
  else
    $(".onoffswitch-checkbox").prop("checked", false);
  # $($('.badge-item')[0]).addClass("col-md-offset-1")
  # $($('.badge-item')[5]).addClass("col-md-offset-1")


Template.assessmentsLeftMenu.helpers
  assessments:()->
    assesments.find().fetch()

# Template.userlistLeftMenu.rendered = () ->
#   $('select').selectize()

Template.enrollmentsLeftMenu.rendered = () ->
  $('select').selectize()

Template.enrollmentsLeftMenu.helpers
  assessments:()->
    assesments.find().fetch()
  nodes:()->
    platforms.findOne().nodes

Template.userlistLeftMenu.helpers
  myusers: () ->
    Meteor.users.find({'personal_profile.display_name' : {$nin : ['Guest User']}}).fetch()
    # Meteor.users.find().fetch()
  profileForUsers :(uid)->
    profiles = []
    if platforms.findOne().profiles?
      for p in platforms.findOne().profiles
        console.log Meteor.users.findOne(uid).profile
        if Meteor.users.findOne(uid).profile is p.name
          p["selected"] = true
        else
          p['selected'] = false
        profiles.push p


    profiles

Template.adminSideBar.rendered = ->
  setTimeout(()->
    # $('.menu-link').first().trigger('click')
    Session.set("contentVar",'info')

  ,300)


Template.adminSideBar.events
  # 'click .topModal':(e)->
  #   showModal('topBarModal',{},'main-wrapper-page-new')

  'click .menu-link':(e)->
    $('.menu-active').removeClass('menu-active')
    $(e.currentTarget).addClass('menu-active')
    temName = $(e.currentTarget).attr('target-templ')
    console.log temName
    Session.set("contentVar",$(e.currentTarget).attr('target-content'))
    $("#left-menu-container").empty();
    Blaze.renderWithData(Template[temName],{},document.getElementById('left-menu-container'))

Template.systemNoticifation.helpers
  passKey:()->
    {ukey:platforms.findOne()._id}


Template.systemNoticifation.events
  'click .new-noti':(e)->
    showModal('newNoti',{ukey:platforms.findOne()._id},'main-wrapper-page-new')

Template.mainAdminPanel.rendered = () ->
  setTitle('Admin Panel')
  $('body').on 'hidden.bs.modal', (e) ->
    # console.log "modal is hidden"
    $('.modal-blur-content').css({"-webkit-filter":"blur(0px)"})
  # do something...
    return


  # ...
Template.mainAdminPanel.helpers
#  assessments:()->
#    assesments.find().fetch()
#  viewQuestion:()->
#    assesments.findOne(Session.get("viewquesId")).scoreQuestions
#  questions:()->
#    scoreQuestions.find().fetch()
#  nodes:()->
#    platforms.findOne().nodes


#  badges:()->
#    platforms.findOne().badges

  passKey:()->
    {ukey:platforms.findOne()._id}
#  setUniqKey:()->
#    {uniqKey:platforms.findOne()._id}
#  myusers: () ->
#    Meteor.users.find().fetch()
#  roles:()->
#    roles.find().fetch()
#  profileForUsers :(uid)->
#    profiles = []
#    if platforms.findOne().profiles?
#      for p in platforms.findOne().profiles
#        console.log Meteor.users.findOne(uid).profile
#        if Meteor.users.findOne(uid).profile is p.name
#          p["selected"] = true
#        else
#          p['selected'] = false
#        profiles.push p
#
#
#    profiles

Template.userlistLeftMenu.events
  'click .add-new-user': (e) ->
    showModal('adduserModal',{userId: -1},'main-wrapper-page-new')

  'keyup #users-filter':(e)->
    searchBar($(e.currentTarget).val(),".user-item")

  'click .edit-user-btn': (e)->
    showModal('adduserModal',{userId: this._id},'main-wrapper-page-new')

  'click .block-user-btn':(e)->
    if window.confirm("Are you sure you want to block this user ?")
      console.log "yes"
    else
      console.log "no"
  'click .reset-user-btn':(e)->
    if window.confirm("Are you sure you want to block this user ?")

      Meteor.call('resetPasswordAdmin',this._id)
      console.log "yes"
    else
      console.log "no"


  'click .delete-user-btn':(e)->
    if window.confirm("Are you sure you want to delete the user?")
      Meteor.call('removeUser',this._id)
      createNotification('Profile has been removed', 1)



  'click .download-template-btn':(e)->
    window.open "/assets/downloadables/userdata_template.xlsx","_blank"

  'click .user-upload-btn': (e)->
    $('.user-upload').trigger('click')

  'change .user-upload': (e)->
    if document.getElementById('new-user-excel').files.length is 0
      createNotification("Please upload a excel",1)
    else
      assessmentQuestions = new FS.File(document.getElementById('new-user-excel').files[0])
      assessmentQuestions.platform = platforms.findOne()._id
      assessmentQuestions.stored = false
      $("#overlay").show()
      rf = excelFiles.insert(assessmentQuestions)
      rfid = rf._id
      Tracker.autorun(()->
        console.log excelFiles.findOne(rfid).stored
        if excelFiles.findOne(rfid).stored
          Meteor.call('bulkInsertUsers',rfid,platforms.findOne()._id)
          $("#overlay").hide()

      )

Template.profilesLeftMenu.events
  'click .profile-delete-btn': (e) ->
    if window.confirm("Are you sure you want to delete the profile?")
      platId = platforms.findOne()._id
      platforms.update({_id: platId}, {$pull: {profiles: this}})
      createNotification("Profile has been removed successfully", 1)
      e.preventDefault()

  'click .add-variants-btn': (e) ->
    showModal('addvariantModal',{},'main-wrapper-page-new')

  'click .add-new-profile': (e) ->
    showModal('addprofileModal',{},'main-wrapper-page-new')

  'keyup #tag-filter':(e)->
    searchBar($(e.currentTarget).val(),".tag-item")


Template.assessmentsLeftMenu.events
  'click .new-question-for-admin': (e) ->
    showModal('newAssessmentModal',{},'main-wrapper-page-new')

  'keyup #tag-filter':(e)->
    searchBar($(e.currentTarget).val(),".tag-assessment")

  'click .add-question': (e) ->
    showModal('newQuestionForAssessmentModal',{},'main-wrapper-page-new')
    Session.set("newquesId",this._id)

  'click .view-question': (e) ->
    showModal('viewQuestionsForAssessmentModal',{},'main-wrapper-page-new')
    Session.set("viewquesId",this._id)

  'click .upload-assessment':(e)->
    $('.assessment-question-upload').trigger('click')
    Session.set("statementName",$(e.currentTarget).attr('id'))

  'change .assessment-question-upload': (e)->
    if document.getElementById('new-question-for-assessment-excel').files.length is 0
      createNotification("Please upload a excel",1)
    else
      assessmentQuestions = new FS.File(document.getElementById('new-question-for-assessment-excel').files[0])
      assessmentQuestions.platform = platforms.findOne()._id
      assessmentQuestions.stored = false
      $("#overlay").show()
      rf = excelFiles.insert(assessmentQuestions)
      rfid = rf._id
      statementId=Session.get("statementName")
      Tracker.autorun(()->
        console.log excelFiles.findOne(rfid).stored
        if excelFiles.findOne(rfid).stored
          Meteor.call('bulkInsertAssessmentQuestions',rfid,platforms.findOne()._id,statementId)
          $("#overlay").hide()

      )

  'click .delete-question-btn':(e)->
    assesments.remove({_id:this._id})

Template.enrollmentsLeftMenu.events
  'click .node-date-assignment':(e)->
    nodes = platforms.findOne().nodes
    pid = platforms.findOne()._id
    $(".enrollment-node").each((ind,ele)->
      if $(ele).find('.node-day').val().length is 0
        val = 1
      else
        val = $(ele).find('.node-day').val()
      assessMent = $(ele).find('.checkbox-assessment').is(":checked")
      selAssessment = $(ele).find('.select-asessment').val()
      nodes[parseInt($(ele).attr('node-seq'))].startDay = val
      nodes[parseInt($(ele).attr('node-seq'))].assessmentNode = assessMent
      nodes[parseInt($(ele).attr('node-seq'))].selAssessment = selAssessment
      console.log nodes[parseInt($(ele).attr('node-seq'))].assessmentNode


#        nodes[parseInt($(ele).attr('node-seq'))].startDate = new Date($(ele).val()).getTime()
#        if parseInt($(ele).next().val()) > 100
#          pm = 100
#        else
#        pm = $(ele).val()

#        console.log $(ele).next().is(':checked')
#        nodes[$(ele).next().is(':checked')].nodeAssessment

    )
    platforms.update({_id:pid},{$set:{nodes:nodes}})

  'keyup #tag-filter':(e)->
    searchBar($(e.currentTarget).val(),".enrollment-node")

Template.manageReport.events
  'click .download-report-btn':(e)->
    showModal('enterpriseOnly',{},'main-wrapper-page-new')
    return
    Meteor.call('exportData',(err,res)->
      if err
        console.log err
      else
        blob = base64ToBlob(res)
        saveAs(blob, 'node.zip')
    )

  'click .download-deck-report-btn':(e)->
    showModal('enterpriseOnly',{},'main-wrapper-page-new')
    return
    Meteor.call('exportDeckDataForAllUsers',(err,res)->
      if err
        console.log err
      else
        blob = base64ToBlob(res)
        saveAs(blob, 'deck.zip')
    )

  'click .download-allnode-report-btn':(e)->
    showModal('enterpriseOnly',{},'main-wrapper-page-new')
    return
    Meteor.call('exportAllNodeDataForAllUsers',platforms.findOne({isMaster:true})._id,(err,res)->
      if err
        console.log err
      else
        blob = base64ToBlob(res)
        saveAs(blob, 'allnode.zip')
    )



  'click .download-alldeck-report-btn':(e)->
    # showModal('enterpriseOnly',{},'main-wrapper-page-new')
    # return
    Meteor.call('exportAllDeckDataForAllUsers',platforms.findOne({isMaster:true})._id,(err,res)->
      if err
        console.log err
      else
        blob = base64ToBlob(res)
        saveAs(blob, 'alldeck.zip')
    )



Template.rewardsLeftMenu.rendered = ->
  if platforms.findOne()['rewards']
    $(".onoffswitch-checkbox").prop("checked", true);
  else
    $(".onoffswitch-checkbox").prop("checked", false);
  # $('').attr("checked")
Template.rewardsLeftMenu.events
  'click .delete-reward':(e)->
    systemRewards.remove({_id:this._id})

  'click .new-reward-form-btn':(e)->
    showModal('newRewardModal',{},'main-wrapper-page-new')

  'keyup #tag-filter':(e)->
    searchBar($(e.currentTarget).val(),".reward-block")

Template.badgesLeftMenu.events
  'click .enterprise-activate-btn':(e)->
    showModal('enterpriseOnly',{},'main-wrapper-page-new')

  'click .update-badge-values':(e)->
    badgeList = []
    $('.badge-item').each((ind,ele)->
      badgeList.push {name:$(ele).attr('badge-name'),value:$(ele).find('input').val()}
    )
    pid = platforms.findOne()._id
    console.log badgeList
    platforms.update({_id:pid},{$set:{badges:badgeList}})

    createNotification("Badges have been updated",1)

  'keyup #tag-filter':(e)->
    searchBar($(e.currentTarget).val(),".badge-item")

Template.rolesLeftMenu.events
  'click .new-role-form-btn':(e)->
    showModal('newRoleModal',{},'main-wrapper-page-new')

  'click .assign-role-form-btn':(e)->
    showModal('assignRoleModal',{},'main-wrapper-page-new')

  'keyup #tag-filter':(e)->
    searchBar($(e.currentTarget).val(),".role")

Template.mainAdminPanel.events

  'click .menu-link':(e)->

    temName = $(e.currentTarget).attr('target-templ')
    console.log temName
    Session.set("contentVar",$(e.currentTarget).attr('target-content'))
    $("#left-menu-container").empty();
    Blaze.renderWithData(Template[temName],{},document.getElementById('left-menu-container'))
#Template.mainAdminPanel.events
#  'shown.bs.modal .modal': (e)->
#    console.log "modal shown"
#
#  'hidden.bs.modal .modal': (e)->
#    console.log "modal hidden"


Template.platformStatus.rendered = () ->
  status = platforms.findOne().platformStatus
  if status == "close"
    $('input:checkbox[name="platformstatus"][value="close"]').prop('checked', true)


Template.platformStatus.events
  'submit #platform-settings':(e)->
    pname = $(e.currentTarget).find("#platform-title").val()
    pga = $(e.currentTarget).find("#platform-ga").val()
    status = $('input[name=platformstatus]:checked').val()
    if status == undefined
      status = "open"
    pid = platforms.findOne()._id
    # if $(e.currentTarget).find('#platform-bkg').files[0]?
    #   bkg = new FS.File($(e.currentTarget).find('#platform-icon').files[0])
    #   bkg.platform = tenantId
    #   bkg.stored = false
    # else
    #   burl = platforms.findOne().backgroundUrl
    # if $(e.currentTarget).find('#platform-logo').files[0]?
    #   bkg = new FS.File($(e.currentTarget).find('#platform-icon').files[0])
    #   bkg.platform = tenantId
    #   bkg.stored = false
    # else
    #   burl = platforms.findOne().platformLogo
    # if $(e.currentTarget).find('#platform-icon').files[0]?
    #   bkg = new FS.File($(e.currentTarget).find('#platform-icon').files[0])
    #   bkg.platform = tenantId
    #   bkg.stored = false
    # else
    #   burl = platforms.findOne().tenantIcon


    platforms.update({_id:pid},{$set:{platformStatus:status,platformTitle:pname,platformGa:pga}})
    createNotification("your platform is now " + status,1)
    false





#  'click .platform-status':(e)->
Template.standardHeader.helpers

  getImage:()->
    Meteor.settings.public.mainLink + platforms.findOne().wrapperJson.imgsrc + "/" + platforms.findOne().wrapperJson.screenshot.backgroundkey
    # ...

Template.standardHeader.events
  'click .onoffswitch-checkbox': (e) ->
    if $(e.currentTarget).hasClass("All")
      if $('.onoffswitch-checkbox').is(":checked")
        if Session.get('contentVar') == "settings"
          pid = platforms.findOne({tenantName:platformName})._id
          platforms.update({_id:pid},{$set:{platformStatus:'close'}})
        Meteor.call('disbaleFeature',platforms.findOne()._id,Meteor.userId(),Session.get('contentVar'),true)
      else
        console.log "ass"
        if Session.get('contentVar') == "settings"
          pid = platforms.findOne({tenantName:platformName})._id
          platforms.update({_id:pid},{$set:{platformStatus:'open'}})
        Meteor.call('disbaleFeature',platforms.findOne()._id,Meteor.userId(),Session.get('contentVar'),false)
    else
      showModal('enterpriseOnly',{},'main-wrapper-page-new')
      e.preventDefault()
