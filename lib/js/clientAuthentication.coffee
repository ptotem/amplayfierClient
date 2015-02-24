#This function cretaes authentication using facebok.



#arguments are success and failure messages and template to be shown on success(the route name)
@authenticateFacebook  = (failureMsg,successMsg,successRouter)->

  Meteor.loginWithFacebook((err)->
    if err
      createNotification(failureMsg,0)
    else
      setTimeout(()->
        Meteor.call("pullDataFromFB",Meteor.userId(),Meteor.user().services.facebook)
        createNotification(successMessages.welcomeSuccess,1)
        Router.go(successRouter)
      ,2000)

  )

#arguments are success and failure messages and template to be shown on success(the route name)
@authenticateTwitter  = (failureMsg,successMsg,successRouter)->

  Meteor.loginWithTwitter((err)->
    if err
      createNotification(failureMsg,0)

    else
      Meteor.call("pullDataFromTwitter",Meteor.userId())

      createNotification(successMsg,1)
      Router.go(successRouter)
  )

@authenticateGitHub  = (failureMsg,successMsg,successRouter)->

  Meteor.loginWithGithub((err)->
    if err

      createNotification(failureMsg,0)

    else
      createNotification(successMsg,1)
      Router.go(successRouter)
  )
@authenticateGoogle  = (failureMsg,successMsg,successRouter)->

  Meteor.loginWithGoogle((err)->
    if err
      createNotification(failureMsg,0)

    else
      Meteor.call("pullDataFromGoogle",Meteor.userId())

      createNotification(successMsg,1)
      Router.go(successRouter)
  )


@authenticateLinkedin  = (failureMsg,successMsg,successRouter)->

  Meteor.loginWithLinkedin((err)->
    if err
      createNotification(failureMsg,0)

    else
      createNotification(successMsg,1)
      Router.go(successRouter)
  )




@authenticatePassword = (userEmail, userPassword,parsed_url)->

#  userEmail = userEmail.split("@")[0]+"|"+tenants.findOne().tenantName+"@"+userEmail.split("@")[1]
  # Session.set("refurl",headers.get("referer"))
  Meteor.loginWithPassword({email: userEmail},userPassword,(err)->
    if err
      $("#overlay").hide()

      createNotification(errorMessages.loginError,0)
    else
      createNotification(successMessages.welcomeSuccess,1)
      if parsed_url
        setTimeout(()->
          $("#overlay").hide()
          window.location = parsed_url
        ,200)

      else
        setTimeout(()->
          window.location = "/"
        ,200)


  )

@createGhostUser = (tname)->
  console.log tname
  userEmail = "user"+new Meteor.Collection.ObjectID()._str+"@ghostuser.com"

  personal_profile = {}
  personal_profile["email"] = "user"+new Meteor.Collection.ObjectID()._str+"@ghostuser.com"
  personal_profile["first_name"] = ""
  personal_profile["last_name"] = ""
  personal_profile["fullname"] = ""
  personal_profile["profilePicLink"] = ""


  aid=Accounts.createUser({email:userEmail,password:"password",tid:-1,role:"player",personal_profile:personal_profile,profiles:['unspecified']}
  )

  Meteor.call("ghostUserAsPlayer",userEmail,tname,(err,res)->
    if res
      Router.go('tenantLanding',{tenant_name:tname})

  )

@createUser = (userObj,successRoute,routeParam)->
  # userObj["email"] = userObj["email"].split("@")[0]+"|"+tenants.findOne().tenantName+"@"+userObj["email"].split("@")[1]
  # userObj["tid"] = tenants.findOne()._id
  console.log userObj

  Meteor.call("checkUserStatus",userObj.email,(err,res)->
    if res is "true"
      Accounts.createUser(userObj ,(err)->
        if err is 403
          $("#overlay").hide()
          createNotification(errorMessages.alredyLoginError,0)
        else
          createNotification(successMessages.loginDoneSuccess,1)
          $("#overlay").hide()
          # window.location="/"
          Router.go(successRoute)
      )
    else
      createNotification(errorMessages.alreadyRegistered,0)

  )

@passwordForgot = (email)->
     Accounts.forgotPassword({email:email},(err)->
       if err?
         createNotification(errorMessages.resetMailNotSent,0)
       else
         createNotification(generalNotifications.resetMailSent,1)

     )
