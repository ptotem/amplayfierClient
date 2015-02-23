Meteor.methods
	storeHtml:(tid,did,tname,dname,htmlString)->
		# deckHtml.remove({})
		p = platforms.insert({tenantId:tid,tenantName:tname})
		console.log p
		d = deckHtml.insert({deckname:dname,platformId:p,tenantId:tid,deckId:did,htmlContent:htmlString})
		console.log d
		return true
		
	syncAssets:(a)->
		console.log a
		if a?
			f = new FS.File('http://localhost:3000'+a)
			console.log f
			gameFiles.insert(f,(err,res)->
				console.log res
				console.log err
			)