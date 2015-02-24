# Template.loginPage.helpers
#   backId:()->
#     tenants.findOne().tenantBack
#   logoId:()->
#     tenants.findOne().tenantLogo
#   getPlatName:()->
#     tenants.findOne().tenantName


Template.loginPage.events
   'submit #loginForm':(e)->
     pn = platformName
     userEmail = $(e.currentTarget).find("#email").val().toString()
    #  newEmail = userEmail.substr(0, userEmail.indexOf('@')) + '|' + pn + userEmail.substr(userEmail.indexOf('@'))
     newEmail = encodeEmail(userEmail,pn)
     console.log newEmail
     userPassword = $(e.currentTarget).find("#password").val()
     authenticatePassword(newEmail,userPassword,"/")
     false
