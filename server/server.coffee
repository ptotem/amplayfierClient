@remoteIp = "http://192.168.89.112:4000"

@myip = "http://192.168.89.118:4000"

@getTenantHtml=(tid,secretKey)->
			x = DDP.connect(remoteIp)
			x.call('requestHTMLForTenant',tid,secretKey,Meteor.settings.secret,(err,res)->
				console.log err
				console.log res
				if !err
					deckHtml.remove({})
					p = platforms.findOne({tenantId:tid})
					deckHtml.remove({platformId:p._id})
					for c in res
						deckHtml.insert({name:c.dName,platformId:p._id,tenantId:tid,deckId:c.deckId,htmlContent:c.deckContent,variants:["Basic","Intermediate","Advanced"]})
			)

@getTenantJs=(tid,secretKey)->
		x = DDP.connect(remoteIp)
		x.call('requestJSForTenant',tid,secretKey,Meteor.settings.secret,(err,res)->
			console.log err
			console.log res
			if !err
				p = platforms.findOne({tenantId:tid})
				deckJs.remove({platformId:p._id})

				for c in res
					deckJs.insert({deckId:c.deckId,panelId:c.panelId,jsContent:c.JSContent,platformId:p._id})
		)

@getTenantMetaData=(tid,secretKey)->
		x = DDP.connect(remoteIp)
		x.call('requestTenantMetaData',tid,secretKey,Meteor.settings.secret,(err,res)->
			console.log err
			console.log res
			if !err
				# Meteor.call('syncTenantAssets',res,tid)
				platforms.update({tenantId:tid},{$set:{backgroundUrl:res.backImage,platformLogo:res.logoImage,tenantIcon:res.favIc}})
		)

@getIntegratedGames=(tid,secretKey)->
		x = DDP.connect(remoteIp)
		x.call('syncTenantGames',tid,secretKey,Meteor.settings.secret,(err,res)->
			console.log err
			console.log res
			exec = Npm.require('child_process').exec
			pwd =  process.env["PWD"]
			for g in res

				child = exec('wget -P  '+ pwd + "/public/games/" + g["gameFileId"] + " " + g["gameFilePath"] , (stderr,stdres,stdout)->
					console.log stderr
					console.log stdres
					console.log stdout
					if stdout
						console.log "successful"
						child = exec('rm -rf   '+ pwd + "/public/mygames/" + g["igId"], (stderr,stdres,stdout)->
							console.log stderr
							console.log stdres
							console.log stdout
						)
						child = exec('mkdir   '+ pwd + "/public/mygames/" + g["igId"], (stderr,stdres,stdout)->
							console.log stderr
							console.log stdres
							console.log stdout
						)
						child = exec('unzip   '+ pwd + "/public/games/" + g["gameFileId"] + "/"+ g["fileName"] + " -d" +  pwd + "/public/mygames/" + g["igId"], (stderr,stdres,stdout)->
							console.log stderr
							console.log stdres
							console.log stdout
						)

				)

		)

@getIntegratedGameQuestions=(tid,secretKey)->
			x = DDP.connect(remoteIp)
			x.call('syncIntegratedGameQuestions',tid,secretKey,Meteor.settings.secret,(err,res)->
				console.log err
				console.log res
				if !err
					p = platforms.findOne({tenantId:tid})
					gameData.remove({platformId:p._id})
					for c in res
						gameData.insert({deckId:c.deckId,igId:c.igId,questions:c.questions,platformId:p._id})
			)

@getCustomizationData=(tid,secretKey)->
			x = DDP.connect(remoteIp)
			x.call('syncCustomizationData',tid,secretKey,Meteor.settings.secret,(err,res)->
				console.log err
				console.log res
				if !err
					p = platforms.findOne({tenantId:tid})
					customizationDecks.remove({platformId:p._id})
					for c in res
						customizationDecks.insert({intGameId:c.integratedGame,custKey:c.custKey,custVal:c.custVal,dataType:c.dataType,platformId:p._id})
			)

@getRequestForTenant=(tid,secretKey)->
			x = DDP.connect(remoteIp)
			x.call('requestStoryWrapperForTenant',tid,secretKey,Meteor.settings.secret,(err,res)->
				console.log err
				console.log res
				pname = platforms.findOne({tenantId:tid}).tenantName
				if !err
					platforms.update({tenantId:tid},{$set:{tenantName:pname,nodes:res.nodes,storyConfig:res.sconfig}})

			)

@getAllAssetsForTenant=(tid,secretKey)->
			x = DDP.connect(remoteIp)
			x.call('requestAssetForTenant',tid,secretKey,Meteor.settings.secret,(err,res)->
				console.log err
				console.log res
				if !err
					console.log "-------------------------------------------------------------"
					console.log res
					Meteor.call('syncTenantAssets',res,tid)
			)



Meteor.methods

	assignUserProfile:(uid,prf)->
		Meteor.users.update({_id:uid},{$set:{profile:prf}})
		true

	createAdminOnClient:(email,tid,platformName)->
		Accounts.createUser({email:encodeEmail(email,platformName),password:"password",role:"admin",tid:tid,personal_profile:{},seed_user:false})

	fetchDataFromCreator:(tid)->
		x = DDP.connect(remoteIp)
		secretKey = platforms.findOne({tenantId:tid}).secretKey

		x.call('checkCreatorConnection',tid,secretKey,Meteor.settings.secret,(err,res)->
			console.log err
			console.log res
			if res is 200
				getTenantHtml(tid,secretKey)
				getTenantJs(tid,secretKey)
				getTenantMetaData(tid,secretKey)
				# getIntegratedGames(tid,secretKey)
				getIntegratedGameQuestions(tid,secretKey)
				getCustomizationData(tid,secretKey)
				getRequestForTenant(tid,secretKey)
				# getAllAssetsForTenant(tid,secretKey)
				platforms.update({tenantId:tid},{$set:{platformSync:true,issyncing:false}})
		)

	authorizeConnection:(tid,tname)->
		x = DDP.connect(remoteIp)
		x.call('authorizeRemoteConnection',Meteor.settings.clientIp,Meteor.settings.secret,(err,res)->
			console.log err
			console.log res
		)



	createPlatform:(tid,tname,secretKey)->
		console.log "Rejmore platfomr recevived"

		if !platforms.findOne({tenantId:tid})?
			# TODO:Archive Platforms before wiping current platform
			# archivePlatforms.insert({platformData:platforms.findOne({tenantId:tid})})
			# platforms.remove({tenantId:tid})
			platforms.insert({tenantId:tid,tenantName:tname,secretKey:secretKey,platformSync:false})
			return true
		else
			return false

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
			if fn["ftype"] is "tenantWrapperData"
				child = exec('wget -P  '+ pwd + "/public/myassetFiles/" + filelist , (stderr,stdres,stdout)->
					console.log stderr
					console.log stdres
					console.log stdout
				)
			else
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
      output: "output.json" , (err, result) ->
        if err
          console.error err
          console.log "if"
        else
          Fiber(()->
            for r,i in result
              if platforms.findOne().userLimit is -1 or Meteor.users.find({platform: pid}).count() < parseInt(platforms.findOne().userLimit)
                newEmail = encodeEmail(r['email'], platformName)
                personal_profile = {platform: pid, email: newEmail, first_name: r['first_name'], last_name: r['last_name'], display_name: r['username']}
                Accounts.createUser({email: newEmail, password: r['password'], platform: pid, personal_profile: personal_profile})
                future.return(true)
              else
                future.return(false)
                break
          ).run()
          return future.wait()


	)

	updateUser:(uid,p)->
		Meteor.users.update({_id:uid},{$set:personal_profile:p})
		return true

	removeUser:(uid)->
		Meteor.users.remove({_id:uid})
		return true

	getPlatformType:(platformId)->
		p = platformType.findOne({platformId:platforms.findOne()._id})
		if p?
			if p.platformLimit?
				if p.platformLimit is -1
					return true
			else
				return false
		else
			return false

  addIndividualUser:(parameter)->
    future = new Future();
    u = Accounts.createUser(parameter)
    if u?
      future.return(true)
    else
      future.return(false)
    return future.wait()

