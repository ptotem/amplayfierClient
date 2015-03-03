@remoteIp = "http://192.168.89.112:4000"

@myip = "http://192.168.89.118:4000"

@getTenantHtml = (tid, secretKey, res)->
  x = DDP.connect(remoteIp)
  x.call('requestHTMLForTenant', tid, secretKey, res, (err, res)->
    console.log err
    console.log res
    if !err
      deckHtml.remove({})
      p = platforms.findOne({tenantId: tid})
      deckHtml.remove({platformId: p._id})
      for c in res
        deckHtml.insert({
          name: c.dName, platformId: p._id, tenantId: tid, deckId: c.deckId, htmlContent: c.deckContent, variants: ["Basic",
                                                                                                                    "Intermediate",
                                                                                                                    "Advanced"]
        })
  )

@getTenantJs = (tid, secretKey, res)->
  x = DDP.connect(remoteIp)
  x.call('requestJSForTenant', tid, secretKey, res, (err, res)->
    console.log err
    console.log res
    if !err
      p = platforms.findOne({tenantId: tid})
      deckJs.remove({platformId: p._id})

      for c in res
        deckJs.insert({deckId: c.deckId, panelId: c.panelId, jsContent: c.JSContent, platformId: p._id})
  )

@getTenantMetaData = (tid, secretKey, res)->
  x = DDP.connect(remoteIp)
  x.call('requestTenantMetaData', tid, secretKey, res, (err, res)->
    console.log err
    console.log res
    if !err
      # Meteor.call('syncTenantAssets',res,tid)
      platforms.update({tenantId: tid},
        {$set: {backgroundUrl: res.backImage, platformLogo: res.logoImage, tenantIcon: res.favIc}})
  )

@getIntegratedGames = (tid, secretKey, res)->
  x = DDP.connect(remoteIp)
  x.call('syncTenantGames', tid, secretKey, res, (err, res)->
    console.log err
    console.log res
    exec = Npm.require('child_process').exec
    pwd = process.env["PWD"]
    for g in res

      child = exec('wget -P  ' + pwd + "/public/games/" + g["gameFileId"] + " " + g["gameFilePath"],
        (stderr, stdres, stdout)->
          console.log stderr
          console.log stdres
          console.log stdout
          if stdout
            console.log "successful"
            child = exec('rm -rf   ' + pwd + "/public/mygames/" + g["igId"], (stderr, stdres, stdout)->
              console.log stderr
              console.log stdres
              console.log stdout
            )
            child = exec('mkdir   ' + pwd + "/public/mygames/" + g["igId"], (stderr, stdres, stdout)->
              console.log stderr
              console.log stdres
              console.log stdout
            )
            child = exec('unzip   ' + pwd + "/public/games/" + g["gameFileId"] + "/" + g["fileName"] + " -d" + pwd + "/public/mygames/" + g["igId"],
              (stderr, stdres, stdout)->
                console.log stderr
                console.log stdres
                console.log stdout
            )
      )
  )

@getIntegratedGameQuestions = (tid, secretKey, res)->
  x = DDP.connect(remoteIp)
  x.call('syncIntegratedGameQuestions', tid, secretKey, res, (err, res)->
    console.log err
    console.log res
    if !err
      p = platforms.findOne({tenantId: tid})
      gameData.remove({platformId: p._id})
      for c in res
        gameData.insert({deckId: c.deckId, igId: c.igId, questions: c.questions, platformId: p._id})
  )

@getCustomizationData = (tid, secretKey, res)->
  x = DDP.connect(remoteIp)
  x.call('syncCustomizationData', tid, secretKey, res, (err, res)->
    console.log err
    console.log res
    if !err
      p = platforms.findOne({tenantId: tid})
      customizationDecks.remove({platformId: p._id})
      for c in res
        customizationDecks.insert({intGameId: c.integratedGame, custKey: c.custKey, custVal: c.custVal, dataType: c.dataType, platformId: p._id})
  )

@getRequestForTenant = (tid, secretKey, res)->
  x = DDP.connect(remoteIp)
  x.call('requestStoryWrapperForTenant', tid, secretKey, res, (err, res)->
    console.log err
    console.log res
    pname = platforms.findOne({tenantId: tid}).tenantName
    if !err
      platforms.update({tenantId: tid}, {$set: {tenantName: pname, nodes: res.nodes, storyConfig: res.sconfig}})
  )

@getAllAssetsForTenant = (tid, secretKey, res)->
  x = DDP.connect(remoteIp)
  x.call('requestAssetForTenant', tid, secretKey, res, (err, res)->
    console.log err
    console.log res
    if !err
      console.log "-------------------------------------------------------------"
      console.log res
      Meteor.call('syncTenantAssets', res, tid)
  )

Meteor.methods

  assignUserProfile: (uid, prf)->
    Meteor.users.update({_id: uid}, {$set: {profile: prf}})
    true

  createAdminOnClient: (email, tid, platformName)->
    pid = platforms.findOne({tenantId: tid})._id
    personal_profile = {platform: pid, email: encodeEmail(email,platformName),  first_name:platformName, last_name: 'Admin', display_name: 'Administrator'}
    newpass = new Meteor.Collection.ObjectID()._str.substr(1,7)
    personal_profile['initialPass'] = newpass
    Accounts.createUser({
      email: encodeEmail(email,
        platformName), password: newpass, role: "admin", platform: pid, personal_profile: personal_profile
    })

  fetchDataFromCreator: (tid)->
    x = DDP.connect(remoteIp)
    secretKey = platforms.findOne({tenantId: tid}).secretKey

    x.call('checkCreatorConnection', tid, secretKey, (err, res)->
      console.log err
      console.log res
      if res isnt -1
        getTenantHtml(tid, secretKey, res)
        getTenantJs(tid, secretKey, res)
        getTenantMetaData(tid, secretKey, res)
        # getIntegratedGames(tid,secretKey)
        getIntegratedGameQuestions(tid, secretKey, res)
        getCustomizationData(tid, secretKey, res)
        getRequestForTenant(tid, secretKey, res)
        # getAllAssetsForTenant(tid,secretKey)
        platforms.update({tenantId: tid}, {$set: {platformSync: true, issyncing: false}})
    )

  authorizeConnection: (tid, tname)->
    x = DDP.connect(remoteIp)
    x.call('authorizeRemoteConnection', Meteor.settings.clientIp, Meteor.settings.secret, (err, res)->
      console.log err
      console.log res
    )

  makePlatformReadyForSyn: (tid, secretKey)->
    if !platforms.findOne({tenantId: tid})?
      platforms.update({tenantId: tid}, {$set: {platformSync: false}})
      return true
    else
      return false

  createPlatform: (tid, tname, secretKey)->
    console.log "Rejmore platfomr recevived"

    if !platforms.findOne({tenantId: tid})?
      # TODO:Archive Platforms before wiping current platform
      # archivePlatforms.insert({platformData:platforms.findOne({tenantId:tid})})
      # platforms.remove({tenantId:tid})
      platforms.insert({tenantId: tid, tenantName: tname, secretKey: secretKey, platformSync: false, issyncing: false})
      return true
    else
      return false

  isReadyForCommunication: (secretKey)->
    if secretKey is "mysecretcode"
      return true
    else
      return false


  storeHtml: (tid, did, tname, dname, htmlString)->
    console.log "HTML storage"
    Fiber = Npm.require('fibers')
    Future = Npm.require('fibers/future')
    future = new Future()
    Fiber(()->
      deckHtml.remove({})
      platforms.remove({})

      p = platforms.insert({tenantId: tid, tenantName: tname})
      # console.log p
      d = deckHtml.insert({name: dname, platformId: p, tenantId: tid, deckId: did, htmlContent: htmlString})
      future.return(true)
    ).run()
    return future.wait()

  storeNodes: (sConfig, nodes, tid, tname)->
    console.log "Syncing "
    p = platforms.update({tenantId: tid}, {$set: {tenantName: tname, nodes: nodes, storyConfig: sConfig}})
    return true



  syncTenantAssets: (fl, tid)->
    p = platforms.findOne({tenantId: tid})
    filelist = " "
    exec = Npm.require('child_process').exec
    pwd = process.env["PWD"]
    for fn in fl
      filelist = filelist + fn["path"] + " "
      if fn["ftype"] is "tenantWrapperData"
        child = exec('wget -P  ' + pwd + "/public/myassetFiles/" + filelist, (stderr, stdres, stdout)->
          console.log stderr
          console.log stdres
          console.log stdout
        )
      else
        child = exec('wget -P  ' + pwd + "/public/mycfsfiles/files/assetFiles/" + fn["fname"] + "/" + filelist,
          (stderr, stdres, stdout)->
            console.log stderr
            console.log stdres
            console.log stdout
        )

    return true



  readWrapperImages: (f, listOfFiles)->
    console.log "----------------------------------"
    console.log listOfFiles
    filelist = " "
    exec = Npm.require('child_process').exec
    for fn in listOfFiles
      console.log "fn"
      console.log fn
      filelist = filelist + ' http://192.168.0.108:3000/assets/storyWrapper/img-spaceWrapper/' + fn + "  "
      console.log filelist
      child = exec('wget -P  /var/www/ampsamp ' + filelist)



  addReport: (repObj) ->
    reports.insert(repObj)
  updateReport: (queryString, parameters) ->
    reports.update(queryString, {$set: parameters})

  updateGameReport: (queryString, parameters) ->
    reports.update(queryString, {$push: {gameData: parameters}})





  syncAssets: (a) ->
    console.log a
    if a?
      f = new FS.File('http://localhost:3000' + a)
      console.log f
      gameFiles.insert(f, (err, res)->
        console.log res
        console.log err
      )

  bulkInsertUsers: Meteor.bindEnvironment((fileid, pid) ->
    platformName = platforms.findOne(pid).tenantName
    file = excelFiles.findOne(fileid)
    Fiber = Npm.require('fibers');
    Future = Npm.require('fibers/future');
    future = new Future();
    xlsxj = Meteor.npmRequire("xlsx-to-json")
    ul = platforms.findOne(pid).userLimit || 100
    xlsxj
      input: '/var/www/userlistfiles/' + file.copies.raw.key
      output: "output.json", (err, result) ->
        if err
          console.error err
          console.log "if"
        else
          Fiber(()->
            for r,i in result
              if platforms.findOne().userLimit is -1 or Meteor.users.find({platform: pid}).count() < parseInt(ul)
                newEmail = encodeEmail(r['email'], platformName)
                personal_profile = {platform: pid, email: newEmail, first_name: r['first_name'], last_name: r['last_name'], display_name: r['username']}
                newpass = new Meteor.Collection.ObjectID()._str.substr(1,7)
                personal_profile['initialPass'] = newpass
                Accounts.createUser({email: newEmail, password: r['password'], platform: pid, personal_profile: personal_profile})

              else
               future.return(false)

          ).run()
    return future.wait()
  )

  updateUser: (uid, p)->
    Meteor.users.update({_id: uid}, {
      $set:
        personal_profile: p
    })
    return true

  removeUser: (uid)->
    Meteor.users.remove({_id: uid})
    return true

  getPlatformType: (platformId)->
    p = platformType.findOne({platformId: platforms.findOne()._id})
    if p?
      if p.platformLimit?
        if p.platformLimit is -1
          return true
      else
        return false
    else
      return false

  addIndividualUser: (p, pid)->
    ul = platforms.findOne(pid).userLimit || 100
    addedUsers = Meteor.users.find({platform: pid}).fetch().length
    console.log addedUsers
    if addedUsers >= ul
      return false
    else
      newpass = new Meteor.Collection.ObjectID()._str.substr(1,7)
      p['initialPass'] = newpass
      Accounts.createUser({email: p['email'], password: newpass, platform: pid, personal_profile: p})


  checkIfUserPasswordSet:(uid)->
    Meteor.users.findOne({_id:uid}).passwordSet
  passwordIsSet:(uid)->
    Meteor.users.update({_id:uid},{$set:{passwordSet:true}})
  resetUserPasswordAdmin:(uid)->
    Meteor.users.update({_id:uid},{$set:{passwordSet:false}})


  forgotMyPassword:(email,captchaData)->
    verifyCaptchaResponse = reCAPTCHA.verifyCaptcha(@connection.clientAddress, captchaData)
    if !verifyCaptchaResponse.success
      console.log 'reCAPTCHA check failed!', verifyCaptchaResponse
      throw new (Meteor.Error)(422, 'Captcha Failed: ' + verifyCaptchaResponse.error)
    else
      u = Meteor.users.findOne({"personal_profile.email":email})
      if u?

        console.log u._id
        Accounts.sendResetPasswordEmail(u._id,email.split("@")[0].split("|")[0]+"@"+email.split("@")[1])
        console.log 'reCAPTCHA verification passed!'
      else
        throw new (Meteor.Error)(422, 'User not found')
