Template.register.events
  'submit #register-form':(e)->
    newUser = $(e.currentTarget).serializeObject()
    Shower.registerForm.validate newUser, (errors, formFieldsObject) ->
      if !errors
        newEmail=encodeEmail(newUser.email, platforms.findOne().tenantName)
        newUser.email = newEmail
        newUser.display_name = newUser.fullname
        $("#overlay").show()
        detectUrl = $(location).attr('href')
        extractUrl = detectUrl.split('?=')[1]
        if extractUrl == null
          extractUrl = "none"
        newUser.type = extractUrl
        newUser.platform = platforms.findOne()._id
        newUser.platformName = platforms.findOne().tenantName
        newUser.createdAt = new Date()
        delete newUser['confirm_password']
        a = createUser(newUser,'/','')
        # Meteor.call('userFromClient',newUser)
        false
      else
        $.each errors, (key,val) ->
          createNotification(key + " : " +val.message,0)
        return false
    false
