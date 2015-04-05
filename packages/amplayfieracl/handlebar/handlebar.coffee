if Meteor.isClient
  UI.registerHelper "can", (code)->

    can(code)
