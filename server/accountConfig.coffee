Accounts.onCreateUser (options, user) ->
  console.log "options " + options.email
  console.log user

#  deliverEmail("rushabh@ptotem.com",options.email,"Welcome","This is a welcome email")
  user.platform = options.platform
  user.personal_profile = options.personal_profile
  user.carts=[]
  user.personal_profile.email = options.email
  user.personal_profile.registration_date = new Date().getTime()

  user.personal_profile.tags = ['unspecified']
  user
