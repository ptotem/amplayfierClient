Template.loginPage.helpers
  backId:()->
    backgroundUrl = ""
    if platforms.findOne()?

      if platforms.findOne().backgroundUrl?
        find = '/cfs'
        re = new RegExp(find, 'g')
#        backgroundUrl = platforms.findOne().backgroundUrl.replace(re,"http://lvh.me:3000/cfs")
        backgroundUrl = platforms.findOne().backgroundUrl.replace(re,"http://gamesayer.com/cfs")
      else
        backgroundUrl = "/assets/images/bg.jpg"
    backgroundUrl

  logoId:()->
    platformLogo = ""
    if platforms.findOne()?
      if platforms.findOne().platformLogo?
        find = '/cfs'
        re = new RegExp(find, 'g')
        platformLogo = platforms.findOne().platformLogo.replace(re,"http://gamesayer.com/cfs")
      else
        platformLogo = "/assets/images/amplayfier-new-logo.png"
    platformLogo

  tenantName:()->
    if platforms.find({isMaster:true}).fetch()[0]?
      if platforms.find({isMaster:true}).fetch()[0].tenantName != undefined
          platforms.find({isMaster:true}).fetch()[0].tenantName


Template.loginPage.events
   'submit #loginForm':(e)->
     pn = platformName
     userEmail = $(e.currentTarget).find("#email").val().toString()
    #  newEmail = userEmail.substr(0, userEmail.indexOf('@')) + '|' + pn + userEmail.substr(userEmail.indexOf('@'))
     newEmail = encodeEmail(userEmail,pn)
     userPassword = $(e.currentTarget).find("#password").val()
     if pn is "tatauatdocumentor"
       link = "/tataPlatform"
     else
       link = "/"
     authenticatePassword(newEmail,userPassword,link)
     false

   'click .signupBtn':(e)->
     e.preventDefault()
     Router.go '/register'




Template.loginPage.rendered = ()->

  $('body').css('height','100%')
  faviconlink = ""
  Tracker.autorun(()->
    if platforms.findOne()?
      if platforms.findOne().tenantIcon?
        find = '/cfs'
        re = new RegExp(find, 'g')
#        faviconlink = platforms.findOne().tenantIcon.replace(re,"http://lvh.me:3000/cfs")
        faviconlink = platforms.findOne().tenantIcon.replace(re,"http://gamesayer.com/cfs")
      else
        faviconlink = '/assets/downloadables/defaultfavicon.ico'
      console.log "-------"
      console.log faviconlink
      console.log "-------"
      $('head').append('<link rel="icon" sizes="16x16 32x32" href="'+faviconlink+'">')
      platformId = platforms.findOne()._id
      # Meteor.call('getPlatformType',platformId,(err,res)->
      # Meteor.call('getPlatformStatus',platformId,(err,res)->

#================================= Auto Logging is commented=======================================
      # if platforms.findOne().tenantName != "tatauatdocumentor"
      #   if platforms.findOne(platformId).platformStatus == "open"
      #     pid = platforms.findOne()._id
      #     email = (new Date).getTime().toString()+"guest@temp.com"
      #     p = {platform: pid, first_name: "Guest", last_name: "User", display_name: "Guest User", email: email}
      #     Accounts.createUser({email: email, password: 'password', platform: pid, personal_profile: p,role:"player"})
      #     #createNotification('Guest user id is created, welcome guest', 1)
      #     authenticatePassword(email,'password',"/")
#================================= Auto Logging is commented=======================================
      # )

  )



  #Functionality to add a guest user and redirecting it back to '/storywrapper' if platform is open
