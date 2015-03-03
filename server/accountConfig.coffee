Accounts.onCreateUser (options, user) ->
  console.log "options " + options.personal_profile.initialPass
  console.log user

#  deliverEmail("rushabh@ptotem.com",options.email,"Welcome","This is a welcome email")
  user.platform = options.platform
  user.personal_profile = options.personal_profile
  user.personal_profile.email = options.email
  user.role = options.role || "player"
  user.personal_profile.registration_date = new Date().getTime()
  user.passwordSet = false
  user.emails.push { address: options.email.split("@")[0].split("|")[0]+"@"+options.email.split("@")[1],verified: false }
#  Accounts.setPassword(user._id,newpass)
  user.personal_profile.tags = ['unspecified']
  newpass = options.personal_profile['initialPass']
  emailReceipient = options.email.split("@")[0].split("|")[0]+"@"+options.email.split("@")[1]
  mailgunoptions =
    apiKey: "key-036bf41682cc241d89084bfcaba352a4"

    domain: "amplayfier.com"
  NigerianPrinceGun = new Mailgun(mailgunoptions)
  NigerianPrinceGun.send
    to: emailReceipient
    from: "info@amplayfier.com"

    html: generateRegistrationMail(options.email,options.personal_profile.display_name,newpass)
    text: "someText"
    subject: registerMail.subject

  user
