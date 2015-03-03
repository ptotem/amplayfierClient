Template.setpassword.rendered = ->

  console.log this.data.uid
  Meteor.call('checkIfUserPasswordSet',Meteor.userId(),(err,res)->
    if res
      window.location = "/"



  )


Template.setpassword.events
  'submit form':(e)->
    if $(e.currentTarget).find('#user-password').val() is $(e.currentTarget).find('#user-old-password').val()
      createNotification("Passwords cannot be kept same",0)
    else
      if $(e.currentTarget).find('#user-password').val() is $(e.currentTarget).find('#user-password-conf').val()
         Accounts.changePassword($(e.currentTarget).find('#user-old-password').val(),$(e.currentTarget).find('#user-password').val(),(err)->
           console.log err
           if err
             createNotification(err.reason,0)
            else
             Meteor.call("passwordIsSet",Meteor.userId())
             window.location = '/'

         )
      else
        createNotification("The two passwords must match",0)
    false

