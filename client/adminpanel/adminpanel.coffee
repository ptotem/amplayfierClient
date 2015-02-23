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

Template.adminpanel.rendered = () ->
	$('.sidelink').first().trigger('click')
	$('.internal-sidelinks').first().trigger('click')



Template.adminpanel.helpers
	myusers: () ->
		Meteor.users.find().fetch()
		# ...