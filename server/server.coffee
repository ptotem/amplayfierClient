Meteor.methods
	syncTenantAssets:(fl)->

		filelist = " "
		exec = Npm.require('child_process').exec
		pwd =  process.env["PWD"]
		for fn in fl
			filelist = filelist + fn["path"] + " "
			child = exec('wget -P  '+ pwd + "/.cfs/files/assetFiles/" + fn["fname"] + "/" + filelist , (stderr,stdres,stdout)->
				console.log stderr
				console.log stdres
				console.log stdout
			)
		return true

	storeHtml:(tid,did,tname,dname,htmlString)->
		# deckHtml.remove({})
		# p = platforms.insert({tenantId:tid,tenantName:tname})
		# console.log p
		d = deckHtml.insert({name:dname,platformId:"T5YDbhsrzpjwgFB6n",tenantId:tid,deckId:did,htmlContent:htmlString})
		console.log d
		return true

  storeNodes:(sConfig,nodes,tid,tname)->
    p = platforms.insert({tenantId:tid,tenantName:tname,nodes:nodes,storyConfig:sConfig})
    return true
  readWrapperImages:(f,listOfFiles)->
    console.log "----------------------------------"
    console.log listOfFiles
    filelist = " "
    exec = Npm.require('child_process').exec
    for fn in listOfFiles
      console.log "fn"
      console.log fn
      filelist = filelist + ' http://192.168.0.104:3000/assets/storyWrapper/img-spaceWrapper/'+fn + "  "
    console.log filelist
    child = exec('wget -P  /var/www/ampsamp '+ filelist)



  addReport:(repObj) ->
    reports.insert(repObj)

  updateReport:(queryString, parameters) ->
    reports.update(queryString,{$set: parameters})

  updateGameReport:(queryString,parameters) ->
    reports.update(queryString,{$push:{gameData:parameters}})





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
