Template.quoleaderBoardUser.rendered =->
	Trackers.autorun(()->
		if ampQuoScore.findOne()? and platforms.findOne()?
			$($('.nav-tabs').find('li')[0]).addClass("active in");
			$("#"+ platforms.findOne().quodecks[0]).addClass("active in");

	)

Template.quoleaderBoardUser.helpers
	leaderBoard:()->
		results = []
		if ampQuoScore.findOne()? and platforms.findOne()?
			for i,q in platforms.findOne().quodecks
				a = {}
				a.quoid = i
				a.quoName = "Year "+ (q+1)
				a.parameters = []
				_.forEach(ampQuoScore.findOne().results, (result, index)->
					# console.log index
					c = {}
					c.name = result.name
					ind = _.indexOf(result.schema, i)
					if _.where(result.data, {userid: Meteor.userId()}).length > 0
						# console.log "In -------" + Meteor.userId()
						console.log _.where(result.data, {userid: Meteor.userId()})
						if _.where(result.data, {userid: Meteor.userId()})[0].quoScores.length > ind
							score = _.where(result.data, {userid: Meteor.userId()})[0].quoScores[ind]
						else	
							score = 0
					else
						score = 0
					c.score = score
					a.parameters.push c
				)
				results.push a

				# console.log "Testing the feature"
				# console.log "Tenants--"
			console.log results
			results
