Template.loginPage.helpers
  backId:()->
    if platforms.findOne().backgroundUrl?
      find = '/cfs'
      re = new RegExp(find, 'g')
      platforms.findOne().backgroundUrl.replace(re,"http://192.168.0.114:3000/cfs")
    else
      "/assets/images/bg.jpg"
  logoId:()->
    if platforms.findOne().platformLogo?
      find = '/cfs'
      re = new RegExp(find, 'g')
      platforms.findOne().platformLogo.replace(re,"http://192.168.0.114:3000/cfs")
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
  $('body').css('height','100%')
  if platforms.findOne().tenantIcon?
    find = '/cfs'
    re = new RegExp(find, 'g')
    faviconlink = platforms.findOne().tenantIcon.replace(re,"http://192.168.0.114:3000/cfs")
  else
    faviconlink = 'http://faviconicon.com/uploads/2010-09-23/1285245556-624813-256.png'
