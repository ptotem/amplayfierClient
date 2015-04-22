Template.adminHeaderBar.events
  'click .logout-link':(e)->
    Meteor.logout()


Template.rewardsLeftMenu.helpers
  rewards:()->
    systemRewards.find().fetch()

Template.profilesLeftMenu.helpers
  getPlatformProfiles: (uid)->
    dep.depend()
    profiles = []
    if platforms.findOne().profiles?
      for p in platforms.findOne().profiles
        p["uid"] = uid
        profiles.push p

    profiles

Template.userlistLeftMenu.helpers
  myusers: () ->
    Meteor.users.find().fetch()
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


Template.adminSideBar.events
  'click .menu-link':(e)->
    temName = $(e.currentTarget).attr('target-templ')
    $("#left-menu-container").empty();
    Blaze.renderWithData(Template[temName],{},document.getElementById('left-menu-container'))

Template.mainAdminPanel.helpers
  assessments:()->
    assesments.find().fetch()
  viewQuestion:()->
    assesments.findOne(Session.get("viewquesId")).scoreQuestions
  questions:()->
    scoreQuestions.find().fetch()
  nodes:()->
    platforms.findOne().nodes


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


    profiles




Template.userlistLeftMenu.events
  'click .add-new-user': (e) ->
    showModal('adduserModal',{},'main-wrapper-page-new')

  'keyup #users-filter':(e)->
    searchBar($(e.currentTarget).val(),".user-item")
  'click .edit-user-btn': (e)->
    $(".right-form").hide()
    $('#myuserCreate').remove()
    Blaze.renderWithData(Template['userForm'], {userId: this._id}, document.getElementById('new-user'))
    $("#new-user").show()
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
