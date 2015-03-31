Template.userEditForm.events
  'click .update-user':(e)->
    display_name = $("#user-name").val()
    first_name = $("#user-first-name").val()
    last_name = $("#user-last-name").val()
    designation = $("#user-designation").val()
    if document.getElementById('profile-pic').files.length isnt 0
      profilePic = new FS.File(document.getElementById('profile-pic').files[0])
      profilePic.owner = Meteor.userId()
      profilePic.stored = false
      pp = assetFiles.insert(profilePic)
      ppid = pp._id
    else
      ppid = Meteor.user().personal_profile.profilePicId
    if document.getElementById('cover-pic').files.length isnt 0
      coverPic = new FS.File(document.getElementById('cover-pic').files[0])
      coverPic.owner = Meteor.userId()
      coverPic.stored = false
      cp = assetFiles.insert(coverPic)
      cpid = cp._id
    else
      cpid = Meteor.user().personal_profile.coverPicId
    if $('#user-password-old').val().length isnt 0
      Accounts.changePassword($('#user-password-old').val(),$('#user-password-new').val(),(err)->
        if err?
          createNotification(err.message,1)
      )
    $('#overlay').show()
    Tracker.autorun(()->
      console.log assetFiles.findOne(ppid).stored
      if assetFiles.findOne(ppid).stored and assetFiles.findOne(cpid).stored
        Meteor.users.update({_id:Meteor.userId()},{$set:{personal_profile:{coverPicId:cpid,profilePicId:ppid,first_name:first_name,last_name:last_name,display_name:display_name,designation:designation}}})
        $('.modal').modal('hide')
        $('.user-edit-form').remove()
        $('#overlay').hide()


    )






# This is not the best approch. Evals can be dangerous
# TODO: Revisit this

# TODO: please chnage this
@executeInteractions = (p)->
  # for d in deckJs.find({panelId:p}).fetch()
  for d in deckJs.find().fetch()
    eval(d.jsContent)


@readHTML = ()->
  $(".actual-text").each((index,ele)->
    $(".actual-text").attr("contenteditable",false)
    $(ele).html(jQuery.parseHTML($(ele).text()))


  )

@executeSlideLoad = (item)->
    item.show()
    item.addClass('active')

    $('.prev-slide').show()
    $('.next-slide').show()
    if $('.slide-container.active').is(":first-child")
     $('.prev-slide').hide()
    if $('.slide-container.active').is(":last-child")
      $(".next-slide").hide()
    item.find('.center-panel[variant-name="'+variantToShow+'"]').first().show('slow',()->
      startTime()
      setCurrentGameId("false")
      setCurrentSlideType(false)
      panelId = $(this).find('.slide-wrapper').attr('panel-id')
      variantName = $(this).attr('variant-name')
      templateId = $(this).attr('template-id')
      setCurrentPanelId(panelId)
      setCurrentSlideId(templateId)
      executeInteractions(panelId)
      setVariantName(variantName)
    )
    item.addClass 'active'

    if parseInt(item.has('iframe').length) isnt 0
      integratedGameId = $('.active').find('iframe').attr('integrated-game-id')
      setCurrentIntegratedGameId(integratedGameId)
      setCurrentSlideId(1)
      triggerInitGame()

#    if parseInt($('.slide-container.active').has('iframe').length) isnt 0
#
#      setCurrentGameId("true")
#      setCurrentSlideType(true)
#
#      setTimeout(()->
#        integratedGameId = $('.active').find('iframe').attr('integrated-game-id')
#        setCurrentIntegratedGameId(integratedGameId)
#        setCurrentSlideId(1)
#        triggerInitGame()
#      ,2000)


#    callStartAttempt(false)



@transitionSlide = ()->
  console.log $('.slide-container.active:visible')
  $('.slide-container.active:visible').hide('slow',(e)->
    setTime(getTime())
    minTime = $($(this).find(".center-panel")).find(".slide-wrapper").attr("min-time")
    maxTime = $($(this).find(".center-panel")).find(".slide-wrapper").attr("max-time")
    points = $($(this).find(".center-panel")).find(".slide-wrapper").attr("points")
    Session.set("currentSlideScore",points)
    setCurrentSlideScore(minTime, maxTime, Session.get("currentSlideScore"))

#        console.log $($(this).find(".center-panel")).attr('template-id')
  )


@initDeck = ()->


  setTimeout(()->
    readHTML()
    startAttempt($(".slide-container").length)

    $(".center-panel[has-data='false']").remove()
    $(".slide-container:empty").remove()
    executeSlideLoad($('.slide-container').first())
    $('.next-slide').on 'click', (e) ->
      nextItem = $('.active').next()
      transitionSlide()
      $('.active').removeClass 'active'
      executeSlideLoad(nextItem)

    $('.prev-slide').on 'click', (e) ->

      prevItem = $('.active').prev()
      transitionSlide()
      $('.active').removeClass 'active'
      executeSlideLoad(prevItem)


  ,100)



Template.storyWrapper.rendered = () ->


  if Meteor.userId()?
    Meteor.call('checkIfUserPasswordSet',Meteor.userId(),(err,res)->
      if !res
        window.location = "/setpassword/"+Meteor.userId()
    )

  if platforms.findOne()?
#    if Meteor.user().badges.indexOf(firstLand.name) is -1
#      firstLand.assign()
    window.platformData.nodes = platforms.findOne().nodes
    # nodesToBeRemoved = []
    # for n in platforms.findOne().nodes
    #   if n.decks isnt null
    #     nodesToBeRemoved.push n
    # console.log nodesToBeRemoved
    # console.log _.difference(platforms.findOne().nodes,nodesToBeRemoved)
    # window.platformData.nodes = nodesToBeRemoved
    # find = /^\/(^)\/storyWrapper/';
    # re = new RegExp(find, 'g');
    s = platforms.findOne().storyConfig

    window.storyConfig = JSON.parse(s);
    window.storyConfig.imgsrc = "http://lvh.me:3000" + window.storyConfig.imgsrc

    pid = platforms.findOne({tenantName: platformName})._id
    window.wrapperDecks = _.compact(deckHtml.find({platformId:pid}).fetch())
    window.userdata["decks"] = []
    for d in _.compact(deckHtml.find({platformId:pid}).fetch())
      window.userdata["decks"].push({deckId:d.deckId,complete:isModuleComplete(d.deckId,Meteor.userId())})

    initPage()

Template.storyWrapper.events
  'click .btn-logout':(e)->
    Meteor.logout()
  'click .user-edit-btn':(e)->
    $('.modal').modal('hide')
    $('.user-edit-form').remove()
    Blaze.renderWithData(Template['userEditForm'], {}, document.getElementById('story-wrapper'))
    $(".modal").modal()

#  'click .fullscreener':(e)->
#    Blaze.renderWithData(Template.homePage,{deckId:currentDisplayedDeckId},document.getElementsByClassName("projector")[0])
  'click #noti-link':(e)->
    setTimeout(()->
      markAllNotiRead(Meteor.userId())
    ,2000)

  'click .admin-icon':(e)->
    $('.menu').slideToggle('slow')
    # window.location = "/admin"



  'click .zone-deck':(e)->

    deckId = $(e.currentTarget).attr("id").split("-")[2]

    setDeckId(deckId)
    if platforms.findOne().profiles?
      for p in platforms.findOne().profiles
        if p.name is Meteor.user().profile
          for v in p.variants
            if v[deckId]?
              setVariantToShow(v[deckId])


   
    if !variantToShow?
      setVariantToShow('Basic')



            # variantToShow = v[deckId]

#    markModuleAsComplete(deckId,Meteor.userId(),tenantId,"true")


    setCurrentDeckId(deckId)
    initDeck()
    Blaze.renderWithData(Template.homePage,{deckId:deckId},document.getElementsByClassName("projector")[0])
  'click #dashboard-launcher':(e)->

    initDash()

Template.storyWrapper.helpers
  getPortalName:()->
    platforms.findOne().tenantName
  passKey:()->
    {ukey:platforms.findOne()._id}
  faqs:()->
    faq
  rewards:()->
    systemRewards.find().fetch()