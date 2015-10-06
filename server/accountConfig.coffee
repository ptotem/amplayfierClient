Accounts.emailTemplates.resetPassword.text = (user, url) ->
  url = url.replace('#/', '');
  pname = platforms.findOne(user.platform).tenantName

  url = url.replace("http://","http://"+pname+".")
  # url = url.replace('http://localhost:3000/', "http://"+process.env.domain_name);
  return "Click this link to reset your password: " + url



# ==============================Commented for Signup====================================
# Accounts.onCreateUser (options, user) ->
#   console.log "options " + options
#   console.log user
#
# #  deliverEmail("rushabh@ptotem.com",options.email,"Welcome","This is a welcome email")
#   user.platform = options.platform
#   user.profile = platforms.findOne(options.platform).profiles[0].name
#   user.personal_profile = options.personal_profile
#   user.personal_profile.email = options.email
#   user.role = options.role || "player"
#   user.personal_profile.registration_date = new Date().getTime()
#   user.passwordSet = false
#   # user.emails.push { address: options.email.split("@")[0].split("|")[0]+"@"+options.email.split("@")[1],verified: false }
# #  Accounts.setPassword(user._id,newpass)
#   user.personal_profile.tags = ['unspecified']
#   # newpass = options.personal_profile['initialPass']
#   emailReceipient = options.email.split("@")[0].split("|")[0]+"@"+options.email.split("@")[1]
#
#   if !Meteor.users.findOne({'personal_profile.email':options.email})?
# #    sendGeneralMail(decodeEmail(options.email),"Welcome, Let's get started....",'newRegister',{uname:options.personal_profile.display_name,uemail:decodeEmail(options.email),pass:newpass})
#     mailgunoptions =
#       apiKey: "key-036bf41682cc241d89084bfcaba352a4"
#
#       domain: "amplayfier.com"
#     NigerianPrinceGun = new Mailgun(mailgunoptions)
#     NigerianPrinceGun.send
#       to: emailReceipient
#       from: "info@amplayfier.com"
#
#       html: generateRegistrationMail(emailReceipient,options.personal_profile.display_name,options.email.split("@")[0].split("|")[1],newpass)
#       text: "someText"
#       subject: registerMail.subject
#
#   user
# ==============================Commented for Signup====================================



Accounts.onCreateUser (options, user) ->
  console.log "options " + options.email
  console.log options

#  deliverEmail("rushabh@ptotem.com",options.email,"Welcome","This is a welcome email")
  if options.role?
    user.role = options.role
  else
    user.role = "player"
  user.tenantid = options.tid
  user.personal_profile = options
  user.carts=[]
  user.platform = options.platform
  newEmail=encodeEmail(options.email, options.platformName)
  user.personal_profile.email = newEmail
  user.personal_profile.registration_date = new Date().getTime()

  user.personal_profile.tags = ['unspecified']
  user.dynamicKeyValue = options.dyanmicField
  user
# THIS FILE IS USED FOR SETTING UP USER ACCOUNTS CONFIGURATION IN THE APPLICATION.
#THE KEYS FOR THIRD PARTY AUTHENTICATION ARE PUT HERE
