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
    # $('.center-panel:visible').attr('has-data') is false
    #   $('.center-panel')
    #$($('.center-panel:visible').find('.slide-wrapper')).bind 'show', ->
    # $('.slide-wrapper').on 'show', ->
    #   alert("Event trigger...");
    #   minTime = $('.center-panel:visible').find(".slide-wrapper").attr("min-time")
    #   maxTime = $('.center-panel:visible').find(".slide-wrapper").attr("max-time")
    #   Session.set("currentSlideScore",parseInt($('.center-panel:visible').find(".slide-wrapper").attr("points")))
    #   setPanelData(minTime,maxTime,Session.get("currentSlideScore"))

    if $('.slide-container.active').is(":first-child")

      $('.prev-slide').hide()
    if $('.slide-container.active').is(":last-child")
      markModuleAsComplete(currentDisplayedDeckId,Meteor.userId(),platforms.findOne()._id,"true")

      $(".next-slide").hide()
    # panelId = $('.slide-container').first().find('.slide-wrapper').attr('panel-id')
    # executeInteractions(panelId)
    item.find('.center-panel[variant-name="'+variantToShow+'"]').first().show()
    item.addClass 'active'
    if parseInt($('.slide-container.active').has('iframe').length) isnt 0

      setCurrentGameId("true")
      setCurrentSlideType(true)
      
      setTimeout(()->
        integratedGameId = $('.active').find('iframe').attr('integrated-game-id')

        setCurrentIntegratedGameId(integratedGameId)
        setCurrentSlideId(1)

        triggerInitGame()
      ,2000)
    else
      setCurrentGameId("false")
      setCurrentSlideType(false)
      panelId = $('.center-panel:visible').find('.slide-wrapper').attr('panel-id')
      variantName = $('.center-panel:visible').attr('variant-name')
      templateId = $('.center-panel:visible').attr('template-id')
      setCurrentPanelId(panelId)
      setCurrentSlideId(templateId)
      executeInteractions(panelId)
      setVariantName(variantName)
    callStartAttempt(false)
    startTime()



@initDeck = ()->

  setTimeout(()->
    readHTML()
    $(".center-panel[has-data='false']").remove()
    $(".slide-container:empty").remove()

    executeSlideLoad($('.slide-container').first())
    $('.next-slide').on 'click', (e) ->
#      setComplete()
      setTime(getTime())
      minTime = $('.center-panel:visible').find(".slide-wrapper").attr("min-time")
      maxTime = $('.center-panel:visible').find(".slide-wrapper").attr("max-time")
      points = $('.center-panel:visible').find(".slide-wrapper").attr("points")


      Session.set("currentSlideScore",points)
      if setCurrentSlideScore(minTime, maxTime, Session.get("currentSlideScore"))
        nextItem = $('.active').next()
        $('.active').hide()
        $('.active').removeClass 'active'
        executeSlideLoad(nextItem)

      return

    $('.prev-slide').on 'click', (e) ->
#      setComplete()
      setTime(getTime())
      minTime = parseInt($('.center-panel:visible').find(".slide-wrapper").attr("min-time"))
      maxTime = parseInt($('.center-panel:visible').find(".slide-wrapper").attr("max-time"))
      points = $('.center-panel:visible').find(".slide-wrapper").attr("points")
      Session.set("currentSlideScore",points)
      if setCurrentSlideScore(minTime, maxTime, Session.get("currentSlideScore"))
#      setPanel()
#      setCurrentSlideScore(minTime, maxTime, Session.get("currentSlideScore"))
        prevItem = $('.active').prev()
        $('.active').hide()
        $('.active').removeClass 'active'
        executeSlideLoad(prevItem)
      return

  ,100)



Template.storyWrapper.rendered = () ->


  if Meteor.userId()?
    Meteor.call('checkIfUserPasswordSet',Meteor.userId(),(err,res)->
      if !res
        window.location = "/setpassword/"+Meteor.userId()



    )

  if platforms.findOne()?
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
#  'click .fullscreener':(e)->
#    Blaze.renderWithData(Template.homePage,{deckId:currentDisplayedDeckId},document.getElementsByClassName("projector")[0])

  'click .admin-icon':(e)->
    $('.menu').slideToggle('slow')
    # window.location = "/admin"



  'click .zone-deck':(e)->

    deckId = $(e.currentTarget).attr("id").split("-")[2]
    deckOpenEvent.trigger();
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
