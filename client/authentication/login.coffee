Template.loginPage.helpers
  backId:()->
    backgroundUrl = ""
    if platforms.findOne().backgroundUrl?
      find = '/cfs'
      re = new RegExp(find, 'g')
      backgroundUrl = platforms.findOne().backgroundUrl.replace(re,"http://amplayfier.com/cfs")
    else
      backgroundUrl = "/assets/images/bg.jpg"
    backgroundUrl

  logoId:()->
    platformLogo = ""
    if platforms.findOne().platformLogo?
      find = '/cfs'
      re = new RegExp(find, 'g')
      platformLogo = platforms.findOne().platformLogo.replace(re,"http://amplayfier.com/cfs")
    else
      platformLogo = "/assets/images/amplayfier-new-logo.png"
    platformLogo


Template.loginPage.events
   'submit #loginForm':(e)->
     pn = platformName
     userEmail = $(e.currentTarget).find("#email").val().toString()
    #  newEmail = userEmail.substr(0, userEmail.indexOf('@')) + '|' + pn + userEmail.substr(userEmail.indexOf('@'))
     newEmail = encodeEmail(userEmail,pn)
     
     userPassword = $(e.currentTarget).find("#password").val()
     authenticatePassword(newEmail,userPassword,"/admin")
     false


Template.loginPage.rendered = ()->
  
  $('body').css('height','100%')
  faviconlink = ""
  if platforms.findOne().tenantIcon?
    find = '/cfs'
    re = new RegExp(find, 'g')
    faviconlink = platforms.findOne().tenantIcon.replace(re,"http://amplayfier.com/cfs")
  else
    faviconlink = 'http://faviconicon.com/uploads/2010-09-23/1285245556-624813-256.png'
  faviconlink


  #Functionality to add a guest user and redirecting it back to '/storywrapper' if platform is open
  platformId = platforms.findOne()._id
  Meteor.call('getPlatformType',platformId,(err,res)->
      if res is true
        pid = platforms.findOne()._id
        email = (new Date).getTime().toString()+"guest@temp.com"
        p = {platform: pid, first_name: "Guest", last_name: "User", display_name: "Guest User", email: email}
        Accounts.createUser({email: email, password: 'password', platform: pid, personal_profile: p,role:"player"})
        #createNotification('Guest user id is created, welcome guest', 1)
        authenticatePassword(email,'password',"/")
       
  )
