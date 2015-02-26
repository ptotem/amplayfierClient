Template.loginPage.helpers
  backId:()->
    if platforms.findOne().backgroundUrl?
      platforms.findOne().backgroundUrl
    else
      "/assets/images/bg.jpg"
  logoId:()->
    if platforms.findOne().platformLogo?
      platforms.findOne().platformLogo
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
    faviconlink = platforms.findOne().tenantIcon
  else
    faviconlink = 'http://faviconicon.com/uploads/2010-09-23/1285245556-624813-256.png'
