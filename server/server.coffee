@sample = ()->
  console.log "sample handler"



#Test server credentials

#@remoteIp = "http://192.168.89.120:4000"
#
#@myip = "http://192.168.89.121:4000"


#Dev server credentials


# @myip = "http://192.168.89.118:4000"
# @remoteIp = "http://192.168.89.112:4000"


# # for local
# @myip = "http://127.0.0.1:4000"
# @remoteIp = "http://127.0.0.1:3000"


# for final
@myip = Meteor.settings.cientIP
@remoteIp = Meteor.settings.creatorIP



@getTenantHtml = (tid, secretKey, res)->
  x = DDP.connect(remoteIp)
  x.call('requestHTMLForTenant', tid, secretKey, res, (err, res)->
    console.log err
    console.log res
    if !err
#      deckHtml.remove({})
      p = platforms.findOne({tenantId: tid})
      deckHtml.remove({platformId: p._id})
      for c in res
        d = deckHtml.insert({
          name: c.dName, platformId: p._id, tenantId: tid, deckId: c.deckId, htmlContent: c.deckContent, variants: ["Basic",
                                                                                                                    "Intermediate",
                                                                                                                    "Advanced"]
        })
        # platforms.update({p._id},{$push:{x}})
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
      platforms.update({tenantId: tid}, {$set: {questions:res.questions,tenantName: pname, nodes: res.nodes, storyConfig: res.sconfig,wrapperJson:res.wrapperJson}})
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

  createAdminOnClient: (email, tid, platformName,platformPwd)->
    console.log "Request for user creation received"

    pid = platforms.findOne({tenantId: tid})._id
    personal_profile = {platform: pid, email: encodeEmail(email,platformName),  first_name:platformName, last_name: 'Admin', display_name: 'Administrator'}
    newpass = platformPwd
    personal_profile['initialPass'] = newpass
    capabilitiesKeys = _.pluck(capabilities.find().fetch(),'code')
    r = addRoles("superadmin","This is the super admin role",capabilitiesKeys,pid)
    personal_profile['role'] = r

    Accounts.createUser({
      email: encodeEmail(email,
        platformName), password: newpass, role: "admin", platform: pid, personal_profile: personal_profile
    })
    Meteor.call("fetchDataFromCreator", tid)

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
  deletePlatform:(tid,tenantName,secretKey)->
    platforms.update({tenantId:tid},{$set:{tenantName:new Meteor.Collection.ObjectID()._str,oldTenantName:tenantName,oldTenantId:tid,tenantId:-1}})

  createPlatform: (tid, tname, secretKey)->
    if !platforms.findOne({tenantId: tid})?
      # TODO:Archive Platforms before wiping current platform
      # archivePlatforms.insert({platformData:platforms.findOne({tenantId:tid})})
      # platforms.remove({tenantId:tid})
#      platforms.update({_id:"AqFLFgDvD5hMBQ8Zh"},{$set:{}})
      platforms.insert({tenantId: tid, tenantName: tname, secretKey: secretKey, platformSync: false, issyncing: false,profiles:[{name: "unspecified", description: "This is the description for unspecified"}],badges:systemBadges.find().fetch()})
      return true
    else
      platforms.update({tenantId:tid},{$set:{secretKey:secretKey,platformSync: false}})
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
#      deckHtml.remove({})
#      platforms.remove({})

      p = platforms.insert({tenantId: tid, tenantName: tname})
      # console.log p
      d = deckHtml.insert({name: dname, platformId: p, tenantId: tid, deckId: did, htmlContent: htmlString})
      # platforms.update({tenantId:tid},{})
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
    console.log "user Uplaod"
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
              console.log r
              if platforms.findOne(pid).userLimit is -1 or Meteor.users.find({platform: pid}).count() < parseInt(ul)
                newEmail = encodeEmail(r['email'], platformName)
                personal_profile = {platform: pid, email: newEmail, first_name: r['first_name'], last_name: r['last_name'], display_name: r['username']}
                newpass = new Meteor.Collection.ObjectID()._str.substr(1,7)
                personal_profile['initialPass'] = newpass
                if 1 is 1
                  personal_profile['role'] = roles.findOne({unikey:pid,rolename:r['role']})._id
                  personal_profile['reportingManager'] = Meteor.users.findOne({'personal_profile.email':encodeEmail(r['manager'], platformName)})._id
                  personal_profile['hrmanager'] = Meteor.users.findOne({'personal_profile.email':encodeEmail(r['hr_manager'], platformName)})._id
                  console.log "User is dine"
                  Accounts.createUser({email: newEmail, password : newpass, platform: pid, personal_profile: personal_profile})


              else
               future.return(false)

          ).run()
    return future.wait()
  )


  bulkInsertAssessmentQuestions: Meteor.bindEnvironment((fileid, pid,statementId) ->
    platformName = platforms.findOne(pid).tenantName
    file = excelFiles.findOne(fileid)
    Fiber = Npm.require('fibers');
    Future = Npm.require('fibers/future');
    future = new Future();
    xlsxj = Meteor.npmRequire("xlsx-to-json")

    xlsxj
      input: '/var/www/userlistfiles/' + file.copies.raw.key
      output: "output.json", (err, result) ->
        if err
          console.error err
          console.log "if"
        else
          Fiber(()->
            for r,i in result
              excelData={statement:r["statement"],min:r["min"],max:r["max"]}
              console.log excelData
              assesments.update({_id:statementId},{$push:{scoreQuestions:excelData}})
          ).run()
    return future.wait()
  )



  updateUser: (uid, p)->
    Meteor.users.update({_id: uid}, {
      $set:
        personal_profile: p
    })
    return true
  updateUserRole: (uid, newRole)->
    Meteor.users.update({_id: uid}, {
      $set:
        'personal_profile.role': newRole
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
    ul = platforms.findOne(pid).userLimit || -1
#    ul = 1
    addedUsers = Meteor.users.find({platform: pid}).fetch().length
    console.log addedUsers
    if ul is -1
      newpass = new Meteor.Collection.ObjectID()._str.substr(1,7)
      p['initialPass'] = newpass

      Accounts.createUser({email: p['email'], password: newpass, platform: pid, personal_profile: p,profile:"unspecified"})
    else
      if addedUsers >= ul
        return false
      else
        newpass = new Meteor.Collection.ObjectID()._str.substr(1,7)
        p['initialPass'] = newpass
        Accounts.createUser({email: p['email'], password: newpass, platform: pid, personal_profile: p})


  checkIfUserPasswordSet:(uid)->
    console.log Meteor.users.findOne({_id:uid}).passwordIsSet
    Meteor.users.findOne({_id:uid}).passwordIsSet
    true
  passwordIsSet:(uid)->
    Meteor.users.update({_id:uid},{$set:{passwordSet:true}})
  resetUserPasswordAdmin:(uid)->
    Meteor.users.update({_id:uid},{$set:{passwordSet:false}})
  resetPasswordAdmin:(uid)->
    newpass = new Meteor.Collection.ObjectID()._str.substr(1,7)
    u = Meteor.users.findOne(uid)
    Accounts.setPassword(u._id, newpass)
    Meteor.users.update({_id:u._id},{$set:{passwordSet:false}})

    e = decodeEmail(u.personal_profile.email)
    n = u.personal_profile.display_name
    sendGeneralMail(e,"Your password has been reset !",'resetPassword',{uname:n,uemail:e,pass:newpass})





  forgotMyPassword:(email,captchaData)->
    verifyCaptchaResponse = reCAPTCHA.verifyCaptcha(@connection.clientAddress, captchaData)
    if !verifyCaptchaResponse.success
      console.log 'reCAPTCHA check failed!', verifyCaptchaResponse
      throw new (Meteor.Error)(422, 'Captcha Failed: ' + verifyCaptchaResponse.error)
    else
      u = Meteor.users.findOne({"personal_profile.email":email})
      if u?

        console.log u._id
        newpass = new Meteor.Collection.ObjectID()._str.substr(1,7)
        Accounts.setPassword(u._id, newpass)
        Meteor.users.update({_id:u._id},{$set:{passwordSet:false}})
        mailgunoptions =
          apiKey: "key-036bf41682cc241d89084bfcaba352a4"

          domain: "amplayfier.com"
        NigerianPrinceGun = new Mailgun(mailgunoptions)
        NigerianPrinceGun.send
          to: email.split("@")[0].split("|")[0]+"@"+email.split("@")[1]
          from: "info@amplayfier.com"

          html: generateNewPassWordMail(email.split("@")[0].split("|")[0]+"@"+email.split("@")[1],u.personal_profile.display_name,email.split("@")[0].split("|")[1],newpass)
          text: "someText"
          subject: 'New Password'
        # Accounts.sendResetPasswordEmail(u._id,email.split("@")[0].split("|")[0]+"@"+email.split("@")[1])
        console.log 'reCAPTCHA verification passed!'
      else
        throw new (Meteor.Error)(422, 'User not found')



  addUserScore:(uid,score)->
      oldScore  = Meteor.users.findOne(uid).personal_profile.score || 0
      newScore = parseInt(oldScore) + parseInt(score)
      Meteor.users.update({_id:uid},{$set:{'personal_profile.score':newScore}})
  redeemReward:(uid,rid)->
    u = Meteor.users.findOne(uid)
    r = systemRewards.findOne(rid)
    if u.currency > r.value
      Meteor.users.update({_id:uid},{$push:{redeemedRewards:rid}})
      updatedCurrency = parseInt(u.currency) - parseInt(r.value)
      Meteor.users.update({_id:uid},{$set:{currency:updatedCurrency}})
      s = parseInt(r.stock) - 1
      systemRewards.update({_id:rid},{$set:{stock:s}})

  updateFlunkCount:(uid)->
    Meteor.users.update({_id:uid},{$inc:{flunkCount:1}})
  setUserScoreFromGame:(uid,scr)->
    Meteor.users.update({_id:uid},{$inc:{points:scr}})
  setUserCurrencyFromGame:(uid,scr)->
    Meteor.users.update({_id:uid},{$inc:{currency:scr}})
  disbaleFeature:(pid,uid,feature,fs)->
    if roles.findOne(Meteor.users.findOne(uid).personal_profile.role).capabilities.indexOf('disable_features') isnt -1
      console.log "ruhaj"
      x = {}
      x[feature] = fs
      platforms.update({_id:pid},{$set:x})

