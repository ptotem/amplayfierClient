Meteor.methods
   isPlatformAvailable:(platformName)->

    if platforms.findOne({tenantName:platformName})?
      true
    else
      false
