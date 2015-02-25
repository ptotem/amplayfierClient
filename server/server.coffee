Meteor.methods
  addReport:(repObj) ->
    reports.insert(repObj)

  updateReport:(queryString, parameters) ->
    reports.update(queryString,{$set: parameters})

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

	bulkInsertUsers : Meteor.bindEnvironment((fileid,pid)->
		platformName = platforms.findOne(pid).tenantName
		file = excelFiles.findOne(fileid)
		Fiber = Npm.require('fibers');
		Future = Npm.require('fibers/future');
		future = new Future();
		xlsxj = Meteor.npmRequire("xlsx-to-json")
		xlsxj
		    input: '/var/www/userlistfiles/'+file.copies.raw.key
		    output: "output.json"
		    , (err, result) ->
		        if err
		          console.error err
		          console.log "if"
		        else
		        	Fiber(()->
		        		for r,i in result
				             newEmail = encodeEmail(r['email'],platformName)
				             personal_profile = {platform:pid,email:newEmail,first_name:r['first_name'],last_name:r['last_name'],display_name:r['username']}
				             Accounts.createUser({email:newEmail,password:r['password'],platform:pid,personal_profile:personal_profile})

		        	).run()


	)

	updateUser:(uid,p)->
		Meteor.users.update({_id:uid},{$set:personal_profile:p})
		return true



