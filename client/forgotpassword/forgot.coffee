Template.forgotPassword.events
	'submit #forgot-password-form': (e) ->
		emailId = $(e.currentTarget).find('#user-email').val()
		captchaData = 
		  captcha_challenge_id: Recaptcha.get_challenge()
		  captcha_solution: Recaptcha.get_response()


		Meteor.call('forgotMyPassword',encodeEmail(emailId,platformName),captchaData,(err,res)->
			if err
				createNotification(err.reason,0)
			else
				createNotification("An email has been sent to you with password reset instructions",1)
				setTimeout(()->
					window.location = "/"
				,2000)
		
			console.log res
			console.log err
		)
		e.preventDefault()
		false
		# ...

Template.resetPassword.events
	'submit #reset-password-form': (e) ->
		pass1 = $(e.currentTarget).find('#user-password').val()
		pass2 = $(e.currentTarget).find('#user-password-conf').val()
		console.log pass1
		console.log pass2
		if pass1 is pass2
			Accounts.resetPassword(token, pass1,()->
        createNotification("Password reset successful",1)
        Meteor.call("passwordIsSet",Meteor.userId())
			)
		else
			createNotification("Password and Password confirmation do not match",0)
		setTimeout(()->
			window.location = "/"
		,2000)
		
		false