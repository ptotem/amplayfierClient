Template.loginPage.helpers
  backId:()->
    if platforms.findOne().backgroundUrl?
      find = '/cfs'
      re = new RegExp(find, 'g')
      platforms.findOne().backgroundUrl.replace(re,"http://amplayfier.com/cfs")
    else
      "/assets/images/bg.jpg"
  logoId:()->
    if platforms.findOne().platformLogo?
      find = '/cfs'
      re = new RegExp(find, 'g')
      platforms.findOne().platformLogo.replace(re,"http://amplayfier.com/cfs")
    else
      "/assets/images/amplayfier-new-logo.png"


Template.loginPage.events
   'submit #loginForm':(e)->
     pn = platformName
     userEmail = $(e.currentTarget).find("#email").val().toString()
    #  newEmail = userEmail.substr(0, userEmail.indexOf('@')) + '|' + pn + userEmail.substr(userEmail.indexOf('@'))
     newEmail = encodeEmail(userEmail,pn)
     console.log newEmail
     userPassword = $(e.currentTarget).find("#password").val()
     authenticatePassword(newEmail,userPassword,"/admin")
     false


Template.loginPage.rendered = ()->
  console.log "Searching for platforms.."
  $('body').css('height','100%')
  if platforms.findOne().tenantIcon?
    find = '/cfs'
    re = new RegExp(find, 'g')
    faviconlink = platforms.findOne().tenantIcon.replace(re,"http://amplayfier.com/cfs")
  else
    faviconlink = 'http://faviconicon.com/uploads/2010-09-23/1285245556-624813-256.png'

  #Functionality to add a guest user and redirecting it back to '/storywrapper' if platform is open
  platformId = platforms.findOne()._id
  Meteor.call('getPlatformType',platformId,(err,res)->
      if res is true
        pid = platforms.findOne()._id
        email = (new Date).getTime().toString()+"guest@temp.com"
        p = {platform: pid, first_name: "Guest", last_name: "User", display_name: "Guest User", email: email}
        Accounts.createUser({email: email, password: 'password', platform: pid, personal_profile: p})
        #createNotification('Guest user id is created, welcome guest', 1)
        authenticatePassword(email,'password',"/")
        console.log("checking if auto login is done");
  )
