Template.adminpanel.events
  'click .delete-question':(e)->
    scoreQuestions.remove({_id:this._id})
  'click .new-question-for-admin-save':(e)->
    nqName = $("#new-question-name").val()
    nqMax = $("#new-question-max").val()
    nqMin = $("#new-question-min").val()

    scoreQuestions.insert({statement:nqName,min:nqMin,max:nqMax,platform:platforms.findOne()._id})


  'click .new-question-for-admin':(e)->
    $("#question-for-admin-list").hide()
    $("#new-question-for-admin").show()

  'click .node-date-assignment':(e)->
    nodes = platforms.findOne().nodes
    pid = platforms.findOne()._id
    $(".node-date").each((ind,ele)->
      if $(ele).val().length isnt 0

        nodes[parseInt($(ele).attr('node-seq'))].endDate = new Date($(ele).val()).getTime()
        if parseInt($(ele).next().val()) > 100
          pm = 100
        else
          pm = $(ele).next().val()
        nodes[parseInt($(ele).attr('node-seq'))].passingMarks = pm

    )
    platforms.update({_id:pid},{$set:{nodes:nodes}})

  'click .update-badge-values':(e)->
    badgeList = []
    $('.badge-item').each((ind,ele)->
      badgeList.push {name:$(ele).attr('badge-name'),value:$(ele).find('input').val()}
    )
    pid = platforms.findOne()._id
    console.log badgeList
    platforms.update({_id:pid},{$set:{badges:badgeList}})

    createNotification("Badges have been updated",1)
  'click .delete-reward':(e)->
    systemRewards.remove({_id:this._id})
  'click .new-reward-save':(e)->
    if document.getElementById('new-reward-file').files.length is 0
      createNotification("Please upload a reward image",1)
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
      Tracker.autorun(()->
        console.log assetFiles.findOne(rfid).stored
        if assetFiles.findOne(rfid).stored
          systemRewards.insert({stock:rewardStock,name:rewardName,description:rewardDesc,value:rewardVal,rewardImage:rfid,pid:platforms.findOne()._id})
          $("#overlay").hide()

      )




  'click .new-noti':(e)->
    $('.noti-container').empty()
    Blaze.renderWithData(Template['newNotification'],{ukey:platforms.findOne()._id},document.getElementsByClassName('noti-container')[0])




  'keyup #tag-filter':(e)->
    searchBar($(e.currentTarget).val(),".tag-item")
  'keyup #users-filter':(e)->
    searchBar($(e.currentTarget).val(),".user-item")
  'keyup #file-filter':(e)->
    searchBar($(e.currentTarget).val(),".file-item")


  'click .reset-user-password-btn':(e)->
    Meteor.call("resetUserPasswordAdmin",this._id,(err,res)->
      createNotification("Password has been reset",1)
    )


  'change .user-profile-chosen':(e)->
    Meteor.call("assignUserProfile",$(e.currentTarget).attr("user-id"),$(e.currentTarget).val(),(err,res)->
      if res
        createNotification("Profile has been assigned successfully",1)
    )

  'click .sync-platform-data': (e)->
    tenantId = platforms.findOne().tenantId
    platforms.update({_id:platforms.findOne()._id},{$set:{issyncing:true}})
    if platforms.findOne().platformSync is true
      createNotification('Cannot Sync',0)
    else
      Meteor.call("fetchDataFromCreator", tenantId, (err, res)->
        console.log err
        console.log res
        if err
          platforms.update({_id:platforms.findOne()._id},{$set:{issyncing:false}})
      )

  'click .preview-icon-admin':(e)->
    window.location = "/"

  'click .add-individual-variant': (e) ->
    arr = []
    $('.userDecks').each (i, v) ->
      #console.log $(v).find('.deckname').val()
      a = {}
      a[$(v).find('.deckname').val()] = $(v).find('.variant-chosen').val()
      arr.push a
      return
    platId = platforms.findOne()._id
    profile = {name: $('#currentProfileName').val(), description: $('#currentProfileDesc').val()}
    platforms.update({_id: platId}, {$pull: {profiles: profile}})
    profile.variants = arr
    platforms.update({_id: platId}, {$push: {profiles: profile}})
    console.log platforms.findOne({_id: platId}).profile
    createNotification("Variants are added to this profile", 1)


  'click .add-variants-btn': (e) ->
    $(".right-form").hide()
    $('#add-varant-to-profile').remove()
    Blaze.renderWithData(Template['addVariant'], {profileName: this.name, profile: this},document.getElementById('add-variant-profile'))
    $("#add-variant-profile").show()
  'click .profile-delete-btn': (e) ->
    if window.confirm("Are you sure you want to delete the profile?")
      platId = platforms.findOne()._id
      platforms.update({_id: platId}, {$pull: {profiles: this}})
      createNotification("Profile has been removed successfully", 1)
      e.preventDefault()

  'click .add-new-profile': (e) ->
    $(".right-form").hide()
    $('#new-prf-form-profile').remove()
    Blaze.renderWithData(Template['addUserProfile'], {userId: -1}, document.getElementById('new-user-profile'))
    $("#new-user-profile").show()


  'click .sidelink': (e) ->
    $('.sidelink').removeClass('active')
    $(e.currentTarget).addClass('active')
    $('.main').hide();
    $("#" + $(e.currentTarget).attr('target-section')).show()
    $("#" + $(e.currentTarget).attr('target-section')).find(".internal-sidelinks").first().trigger('click')
    $("#" + $(e.currentTarget).attr('target-section')).find(".help-area").first().show()

  'click .download-template-btn':(e)->
    window.open "/assets/downloadables/userdata_template.xlsx","_blank"


  'click .internal-sidelinks': (e) ->

    $('.internal-sidelinks').removeClass('active')
    $(e.currentTarget).addClass('active')
    $('.right-form ').hide()
    $("#" + $(e.currentTarget).attr('target-section')).show()
    $('.help-area').hide()
    $("#" + $(e.currentTarget).attr('help-area')).show()
    if $(e.currentTarget).hasClass('chosen-sel')
        $('#usersemails').chosen({width:'100%'})
        $('#usersemails2').chosen({width:'100%'})





  'click .user-upload-btn': (e)->
    $('.user-upload').trigger('click')

  'change .user-upload': (e)->
    f = new FS.File(document.getElementById("new-user-excel").files[0])
    f.platformId = -1
    nef = excelFiles.insert(f)
    pid = platforms.findOne()._id
    console.log nef
    setTimeout(()->
      Meteor.call('bulkInsertUsers', nef._id, pid, (err, res)->
        if res is true
          createNotification('Users successfully created',1)
        else
          createNotification("You are not allowed to add any more user, please upgrade to add more user", 0)
      )
    , 3000)
  'click .add-new-user': (e)->
    $(".right-form").hide()
    $('#myuserCreate').remove()
    Blaze.renderWithData(Template['userForm'], {userId: -1}, document.getElementById('new-user'))
    $("#new-user").show()


  'click .edit-user-btn': (e)->
    $(".right-form").hide()
    $('#myuserCreate').remove()
    Blaze.renderWithData(Template['userForm'], {userId: this._id}, document.getElementById('new-user'))
    $("#new-user").show()

  'click .delete-user-btn':(e)->
    if window.confirm("Are you sure you want to delete the user?")
      Meteor.call('removeUser',this._id)
      createNotification('Profile has been removed', 1)


Template.adminpanel.rendered = () ->
#  $('select').chosen({
#    "width":"30%"
#
#  })
  setTitle('amplayfier | Manage User Profiles & Reports');
  $('.node-date').datepicker()
  $(".node-date").each((ind,ele)->
    if platforms.findOne().nodes[ind].endDate?
      ed = platforms.findOne().nodes[ind].endDate
    else
      ed = new Date().getTime()
    edate = new Date(ed)

    $(ele).datepicker  'setDate', new Date(edate.getFullYear(),edate.getMonth() , edate.getDate())

  )
#  $(".node-date").datetimepicker(
#    defaultDate:new Date()
#  )


  Tracker.autorun(()->
    if platforms.findOne().issyncing is true
      $('#overlay').show()
    else
      if $("#overlay").is(":visible")
        $('#overlay').hide()
  )

#  if Meteor.users.findOne({_id:Meteor.userId()}).role is "player"
#    window.location = "/"
#

  $('.sidelink').first().trigger('click')
    # $('.internal-sidelinks').first().trigger('click')
#    $('#tag-list').mCustomScrollbar();
#    $('#user-list').mCustomScrollbar();
  #  $(".content").mCustomScrollbar();

Template.adminpanel.helpers
  questions:()->
    scoreQuestions.find().fetch()
  nodes:()->
    platforms.findOne().nodes

  rewards:()->
    systemRewards.find().fetch()
  badges:()->
    platforms.findOne().badges

  passKey:()->
    {ukey:platforms.findOne()._id}
  setUniqKey:()->
    {uniqKey:platforms.findOne()._id}
  myusers: () ->
    Meteor.users.find().fetch()
  roles:()->
    roles.find().fetch()
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
    console.log profiles

    profiles

  getPlatformProfiles: (uid)->
    dep.depend()
    profiles = []
    if platforms.findOne().profiles?
      for p in platforms.findOne().profiles
        p["uid"] = uid
        profiles.push p

    profiles

Template.userForm.events
  'click .add-individual-user': (e) ->
    email = $("#user-email").val()
    newemail = encodeEmail(email, platformName)

    display_name = $("#user-name").val()
    first_name = $("#user-first-name").val()
    last_name = $("#user-last-name").val()
    reportingTo = $(".reporting-mgr").val()
    role = $('.user-role').val()
    currUserFname=Meteor.users.findOne({_id:Meteor.userId()}).personal_profile.first_name
    currUserLname=Meteor.users.findOne({_id:Meteor.userId()}).personal_profile.last_name

    pid = platforms.findOne()._id

    p = {platform: pid, first_name: first_name, last_name: last_name, display_name: display_name, email: newemail,reportingManager:reportingTo,role:role}

    if $("#user-id").val() == ''
      Meteor.call("addIndividualUser",p,pid,(err,res)->


        if err?
          createNotification(err.message,0)
        else
          if !res
            createNotification('User Limit reached',0)

          else
            Meteor.call("sendUserAddMailGunMail",email,first_name,last_name,currUserFname,currUserLname)
            createNotification("User successfully added",1)

      )

    else
      p = Meteor.users.findOne($("#user-id").val()).personal_profile

      p['platform'] = pid
      p['first_name'] = first_name
      p['last_name'] = last_name
      p['display_name'] = display_name
      p['reportingManager'] = reportingTo
      p['role'] = role

      Meteor.call('updateUser',$("#user-id").val(),p)
      Meteor.call("sendUserAddMailGunMail",email,first_name,last_name,currUserFname,currUserLname)
      createNotification('Profile has been updated', 1)

Template.userForm.helpers
  myuser: (uid) ->
    if uid isnt -1
      Meteor.users.findOne(uid)
    else
      {}
  myusers: () ->
    Meteor.users.find().fetch()
  roles:()->
    roles.find().fetch()

Template.userForm.rendered = ()->
  uid = this.data.userId
  u = Meteor.users.findOne(uid).personal_profile
  setTimeout(()->
    $('.reporting-mgr').val(u.reportingManager)
    $(".user-role").val(u.role)
  ,500)


Template.addUserProfile.events
  'click .add-individual-profile': (e)->
    profile = {name: $("#profile-name").val(), description: $("#profile-desc").val()}
    platId = platforms.findOne()._id
    platforms.update({_id: platId}, {$push: {profiles: profile}})
    createNotification("Profile has been added successfully", 1)
    $(".internal-sidelinks.active").trigger('click')


Template.addVariant.helpers
  userDeckHtml: ()->
    deckHtml.find().fetch()

  deckVariants: (deckId)->
    variants = []
    deck = deckHtml.findOne(deckId)
    if deck.variants?
      for j in deck.variants
        variants.push({userVariants: j})
    variants


Template.adminLogout.events
  'click #logout': (e) ->
    Meteor.logout()
    setTimeout (->
      window.location.href = window.location.href
    ), 1000
