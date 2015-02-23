Template.adminpanel.events
	'click .sidelink': (e) ->
		$('.active').removeClass('active')
		$(e.currentTarget).addClass('active')
		$('.main').hide()
		$("#"+$(e.currentTarget).attr('target-section')).show()
	'click .internal-sidelinks': (e) ->
		$('.active').removeClass('active')
		$(e.currentTarget).addClass('active')
		$('.right-form ').hide()
		$("#"+$(e.currentTarget).attr('target-section')).show()
	'click .user-upload-btn':(e)->
		$('.user-upload').trigger('click')

	'change .user-upload':(e)->
		f = new FS.File(document.getElementById("new-user-excel").files[0])
		f.platformId = -1
		nef = excelFiles.insert(f)
		pid = platforms.findOne()._id
		console.log nef
		setTimeout(()->
			Meteor.call('bulkInsertUsers',nef._id,pid,(err,res)->
				if res
					console.log "Users have been uploaded..."
			)
		,3000)
	'click .add-new-user':(e)->
		$(".right-form").hide()
		Blaze.renderWithData(Template['userForm'],{},document.getElementById('new-user'))
		$("#new-user").show()
Template.adminpanel.rendered = () ->
	$('.sidelink').first().trigger('click')
	$('.internal-sidelinks').first().trigger('click')



Template.adminpanel.helpers
	myusers: () ->
		Meteor.users.find().fetch()
		# ...

Template.userForm.events
	'click .add-individual-user': (e) ->
		email = $("#user-email").val()
		display_name =  $("#user-name").val()
		first_name =  $("#user-first-name").val()
		last_name =  $("#user-last-name").val()
		
		pid = platforms.findOne()._id
		p = {platform:pid,first_name:first_name,last_name:last_name,display_name:display_name}
		Accounts.createUser({email:email,password:'password',platform:pid,personal_profile:p})

