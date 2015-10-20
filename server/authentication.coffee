Meteor.methods


  isRoleAdmin:(uid)->
    if Meteor.users.findOne({_id:uid}).role?
      if Meteor.users.findOne({_id:uid}).role == "admin"
        true
      else
        false


   isPlatformAvailable:(platformName)->

    if platforms.findOne({tenantName:platformName})?
      true
    else
      false

   isTataPlatform:(platformName)->

    if platforms.findOne({tenantName:platformName})?
      if platformName is "tatauatdocumentor"
        true
      else
        false  
