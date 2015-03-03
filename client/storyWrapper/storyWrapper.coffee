# This is not the best approch. Evals can be dangerous
# TODO: Revisit this

@executeInteractions = (p)->
  for d in deckJs.find({panelId:p}).fetch()
    eval(d.jsContent)

@executeSlideLoad = (item)->
    item.show()
    # panelId = $('.slide-container').first().find('.slide-wrapper').attr('panel-id')
    # executeInteractions(panelId)
    item.find('.center-panel[variant-name="'+variantToShow+'"]').first().show()
    item.addClass 'active'
    if $('.center-panel:visible').has('iframe').length isnt 0
      setCurrentGameId("true")
      setCurrentSlideType(true)
      integratedGameId = $('.active').find('iframe').attr('integrated-game-id')
      setCurrentIntegratedGameId(integratedGameId)
      setTimeout(()->
        triggerInitGame()
      ,500)
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
    executeSlideLoad($('.slide-container').first())
    $('.next-slide').on 'click', (e) ->
      setComplete()
      setTime(getTime())
      nextItem = $('.active').next()
      $('.active').hide()
      $('.active').removeClass 'active'
      executeSlideLoad(nextItem)
      
      return

    $('.prev-slide').on 'click', (e) ->
      setComplete()
      setTime(getTime())
      prevItem = $('.active').prev()
      $('.active').hide()
      $('.active').removeClass 'active'
      executeSlideLoad(prevItem)
      return

  ,100)



Template.storyWrapper.rendered = () ->
  console.log platforms.findOne().nodes
  if platforms.findOne()?
    window.platformData.nodes = platforms.findOne().nodes
    # find = /^\/(^)\/storyWrapper/';
    # re = new RegExp(find, 'g');
    s = platforms.findOne().storyConfig

    window.storyConfig = JSON.parse(s);
    window.storyConfig.imgsrc = "http://amplayfier.com" + window.storyConfig.imgsrc
    pid=platforms.findOne({tenantName: platformName})._id
    window.wrapperDecks = _.compact(deckHtml.find({platformId:pid}).fetch())
    window.userdata["decks"] = []
    for d in _.compact(deckHtml.find({platformId:pid}).fetch())
      window.userdata["decks"].push({deckId:d.deckId,complete:isModuleComplete(d._id,Meteor.userId())})

    initPage()

Template.storyWrapper.events
  'click .zone-deck':(e)->
    deckId = $(e.currentTarget).attr("id").split("-")[2]
    for p in platforms.findOne().profiles
      if p.name is Meteor.user().profile
        for v in p.variants
          if v[deckId]?
            setVariantToShow(v[deckId])
            # variantToShow = v[deckId]

    markModuleAsComplete(deckId,Meteor.userId(),tenantId,"true")


    setCurrentDeckId(deckId)
    initDeck()
    Blaze.renderWithData(Template.homePage,{deckId:deckId},document.getElementsByClassName("projector")[0])
