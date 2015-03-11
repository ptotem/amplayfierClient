Template.adminpanel.events
  'keyup #tag-filter':(e)->
    searchBar($(e.currentTarget).val(),".tag-item")
  'keyup #users-filter':(e)->
    searchBar($(e.currentTarget).val(),".user-item")

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


  'click .internal-sidelinks': (e) ->
    $('.internal-sidelinks').removeClass('active')
    $(e.currentTarget).addClass('active')
    $('.right-form ').hide()
    $("#" + $(e.currentTarget).attr('target-section')).show()
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
  Tracker.autorun(()->
    if platforms.findOne().issyncing is true
      $('#overlay').show()
    else
      if $("#overlay").is(":visible")
        $('#overlay').hide()
  )

  if Meteor.users.findOne({_id:Meteor.userId()}).role is "player"
    window.location = "/"
  else

    $('.sidelink').first().trigger('click')
    $('.internal-sidelinks').first().trigger('click')
#    $('#tag-list').mCustomScrollbar();
#    $('#user-list').mCustomScrollbar();
  #  $(".content").mCustomScrollbar();

Template.adminpanel.helpers
  myusers: () ->
    Meteor.users.find().fetch()
  profileForUsers :(uid)->
    profiles = []
    if platforms.findOne().profiles?
      for p in platforms.findOne().profiles.reverse()
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
      for p in platforms.findOne().profiles.reverse()
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
    currUserFname=Meteor.users.findOne({_id:Meteor.userId()}).personal_profile.first_name
    currUserLname=Meteor.users.findOne({_id:Meteor.userId()}).personal_profile.last_name

    pid = platforms.findOne()._id
    p = {platform: pid, first_name: first_name, last_name: last_name, display_name: display_name, email: newemail}

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
      Meteor.call('updateUser', $("#user-id").val(), p)
      Meteor.call("sendUserAddMailGunMail",email,first_name,last_name,currUserFname,currUserLname)
      createNotification('Profile has been updated', 1)

Template.userForm.helpers
  myuser: (uid) ->
    if uid isnt -1
      Meteor.users.findOne(uid)
    else
      {}


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
