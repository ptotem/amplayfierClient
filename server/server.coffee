Meteor.methods
	authorizeConnection:(tid,tname)->
		x = DDP.connect(Meteor.settings.creatorIp)
		# x.call('authorizeRemoteConnection',Meteor.settings.clientIp,Meteor.settings.secret,(err,res)->
		# 	console.log err
		# 	console.log res
		# )
		# x.call('requestHTMLForTenant',tid,Meteor.settings.secret,(err,res)->
		# 	console.log err
		# 	if !err
		# 		deckHtml.remove({})
		# 		p = platforms.findOne({tenantId:tid})
		# 		for c in res
		# 			deckHtml.insert({name:c.dName,platformId:p._id,tenantId:tid,deckId:c.deckId,htmlContent:c.deckContent})
		# )
		# x.call('requestStoryWrapperForTenant',tid,Meteor.settings.secret,(err,res)->
		# 	console.log err
		# 	console.log res
		# 	if !err
		# 		platforms.update({tenantId:tid},{$set:{tenantName:tname,nodes:res.nodes,storyConfig:res.sconfig}})
		#
		# )
		# x.call('requestAssetForTenant',tid,Meteor.settings.secret,(err,res)->
		# 	console.log err
		# 	console.log res
		# 	if !err
		# 		Meteor.call('syncTenantAssets',res,tid)
		# )
		# x.call('requestJSForTenant',tid,Meteor.settings.secret,(err,res)->
		# 	console.log err
		# 	console.log res
		# 	if !err
		# 		for c in res
		# 			deckJs.insert({deckId:c.deckId,panelId:c.panelId,jsContent:c.JSContent})
		# )
		# x.call('requestTenantMetaData',tid,Meteor.settings.secret,(err,res)->
		# 	console.log err
		# 	console.log res
		# 	if !err
		# 		Meteor.call('syncTenantAssets',res,tid)
		# 		platforms.update({tenantId:tid},{$set:{backgroundUrl:res.backImage,platformLogo:res.logoImage,tenantIcon:res.favIc}})
		# )
		# x.call('syncTenantGames',tid,Meteor.settings.secret,(err,res)->
		# 	console.log err
		# 	console.log res
		# 	exec = Npm.require('child_process').exec
		# 	pwd =  process.env["PWD"]
		# 	for g in res
		#
		# 		child = exec('wget -P  '+ pwd + "/public/games/" + g["gameFileId"] + " " + g["gameFilePath"] , (stderr,stdres,stdout)->
		# 			console.log stderr
		# 			console.log stdres
		# 			console.log stdout
		# 			if stdout
		# 				console.log "successful"
		# 				child = exec('mkdir   '+ pwd + "/public/mygames/" + g["igId"], (stderr,stdres,stdout)->
		# 					console.log stderr
		# 					console.log stdres
		# 					console.log stdout
		# 				)
		# 				child = exec('unzip   '+ pwd + "/public/games/" + g["gameFileId"] + "/"+ g["fileName"] + " -d" +  pwd + "/public/mygames/" + g["igId"], (stderr,stdres,stdout)->
		# 					console.log stderr
		# 					console.log stdres
		# 					console.log stdout
		# 				)
		#
		# 		)
		#
		# )
		x.call('syncIntegratedGames',tid,Meteor.settings.secret,(err,res)->
			console.log err
			console.log res
			if !err
				for c in res
					gameData.insert({deckId:c.deckId,igId:c.igId,questions:c.questions})
		)
		x.call('syncCustomizationData123',tid,Meteor.settings.secret,(err,res)->
			console.log err
			console.log res
			if !err
				for c in res
					customizationDecks.insert({intGameId:c.integratedGame,custKey:c.custKey,custVal:c.custVal,dataType:c.dataType})
		)

	createPlatform:(tid,tname)->
		p = platforms.insert({tenantId:tid,tenantName:tname})


	isReadyForCommunication:(secretKey)->
		if secretKey is "mysecretcode"
			return true
		else
			return false


	storeHtml:(tid,did,tname,dname,htmlString)->
		console.log "HTML storage"
		Fiber = Npm.require('fibers')
		Future = Npm.require('fibers/future')
		future = new Future()
		Fiber(()->
			deckHtml.remove({})
			platforms.remove({})

			p = platforms.insert({tenantId:tid,tenantName:tname})
			# console.log p
			d = deckHtml.insert({name:dname,platformId:p,tenantId:tid,deckId:did,htmlContent:htmlString})
			future.return(true)

		).run()
		return future.wait()

	storeNodes:(sConfig,nodes,tid,tname)->
		console.log "Syncing "
		p = platforms.update({tenantId:tid},{$set:{tenantName:tname,nodes:nodes,storyConfig:sConfig}})
		return true



	syncTenantAssets:(fl,tid)->

		p = platforms.findOne({tenantId:tid})
		filelist = " "
		exec = Npm.require('child_process').exec
		pwd =  process.env["PWD"]
		for fn in fl
			filelist = filelist + fn["path"] + " "
			child = exec('wget -P  '+ pwd + "/public/mycfsfiles/files/assetFiles/" + fn["fname"] + "/" + filelist , (stderr,stdres,stdout)->
				console.log stderr
				console.log stdres
				console.log stdout
			)
		return true



  readWrapperImages:(f,listOfFiles)->
    console.log "----------------------------------"
    console.log listOfFiles
    filelist = " "
    exec = Npm.require('child_process').exec
    for fn in listOfFiles
      console.log "fn"
      console.log fn
      filelist = filelist + ' http://192.168.0.108:3000/assets/storyWrapper/img-spaceWrapper/'+fn + "  "
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
