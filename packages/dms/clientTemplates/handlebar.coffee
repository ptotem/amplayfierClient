if Meteor.isClient
	UI.registerHelper 'getUrl',(id)->
		window[Session.get('collUsed')].findOne(id).url()
	UI.registerHelper 'hasDocs',()->
		console.log window[Session.get('collUsed')].find().fetch().length > 0
		window[Session.get('collUsed')].find().fetch().length > 0
