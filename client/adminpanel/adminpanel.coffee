Template.adminpanel.events
	'click .profile-delete-btn': (e) ->
	    #alert("Testing delete")
      platId=platforms.findOne()._id
      platforms.update({_id:platId},{$pull:{profiles:this}})
      alert("platId")
      createNotification("Profile has been removed successfully",1)
      e.preventDefault()

	'click .add-new-profile': (e) ->
		$(".right-form").hide()
		$('#new-prf-form-profile').remove()
		Blaze.renderWithData(Template['addUserProfile'],{userId:-1},document.getElementById('new-user-profile'))
		$("#new-user-profile").show()

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
		Blaze.renderWithData(Template['userForm'],{userId:-1},document.getElementById('new-user'))
		$("#new-user").show()


	'click .edit-user-btn':(e)->
		$(".right-form").hide()
		Blaze.renderWithData(Template['userForm'],{userId:this._id},document.getElementById('new-user'))
		$("#new-user").show()


Template.adminpanel.rendered = () ->
	$('.sidelink').first().trigger('click')
	$('.internal-sidelinks').first().trigger('click')



Template.adminpanel.helpers
	myusers: () ->
		Meteor.users.find().fetch()

	getPlatformProfiles:(uid)->
    profiles = []
    for p in platforms.findOne().profiles
      p["uid"] = uid
      profiles.push p
    console.log profiles
    profiles

		# ...

Template.userForm.events
	'click .add-individual-user': (e) ->

		email = $("#user-email").val()
		console.log email
		email = encodeEmail(email,platformName)
		console.log email
		display_name =  $("#user-name").val()
		first_name =  $("#user-first-name").val()
		last_name =  $("#user-last-name").val()

		pid = platforms.findOne()._id
		p = {platform:pid,first_name:first_name,last_name:last_name,display_name:display_name,email:email}

		if parseInt($("#user-id").val()) is -1

			Accounts.createUser({email:email,password:'password',platform:pid,personal_profile:p})
		else
			console.log $("#user-id").val()
			Meteor.call('updateUser',$("#user-id").val(),p)
			createNotification('Profile has been updated',1)

Template.userForm.helpers
	myuser: (uid) ->
		if uid isnt -1
			Meteor.users.findOne(uid)
		else
			{}


Template.addUserProfile.events
	'click .add-individual-profile':(e)->
		profile = {name:$("#profile-name").val(),description:$("#profile-desc").val()}
		platId=platforms.findOne()._id
		platforms.update({_id:platId},{$push:{profiles:profile}})
		createNotification("Profile has been added successfully",1)
