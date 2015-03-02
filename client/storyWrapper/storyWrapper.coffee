@executeInteractions = (p)->
  # $(".component").hide()
  for d in deckJs.find({panelId:p}).fetch()
    console.log d.jsContent
    eval(d.jsContent)


@initDeck = ()->

  setTimeout(()->
    console.log "grg"
    $('.slide-container').first().show()
    $('.slide-container').first().find('.slide-wrapper').attr('panel-id')
    executeInteractions($('.slide-container').first().find('.slide-wrapper').attr('panel-id'))
    $('.slide-container').first().find('.center-panel').first().show()
    $('.slide-container').first().addClass 'active'

    if $('.slide-container').has('iframe').length isnt 0
      setCurrentGameId("true")
      setCurrentSlideId(11)

      setCurrentSlideType(true)
      setCurrentIntegratedGameId($('.active').find('iframe').attr('integrated-game-id'))
      setTimeout(()->
        triggerInitGame()
      ,500)
    else
      setCurrentGameId("false")
      setCurrentSlideType(false)

    startTime()
    callStartAttempt(false)
    $('.next-slide').on 'click', (e) ->
      nextItem = $('.active').next()
      $('.active').hide()
      $('.active').removeClass 'active'
      nextItem.show()
      nextItem.find('.center-panel').first().show()
      executeInteractions(nextItem.find('.slide-wrapper').attr('panel-id'))


      nextItem.addClass 'active'
      if $('.slide-container').has('iframe').length isnt 0
        setCurrentGameId("true")
        setCurrentSlideId(11)

        setCurrentSlideType(true)
        setCurrentIntegratedGameId($('.active').find('iframe').attr('integrated-game-id'))
        setTimeout(()->
          triggerInitGame()
        ,500)
      else
        setCurrentGameId("false")
        setCurrentSlideType(false)
      setComplete()
      setTime(getTime())
      callStartAttempt(true)
      startTime()
      return
    $('.prev-slide').on 'click', (e) ->
      nextItem = $('.active').prev()
      $('.active').hide()
      $('.active').removeClass 'active'
      nextItem.show()
      executeInteractions(nextItem.find('.slide-wrapper').attr('panel-id'))

      nextItem.addClass 'active'
      if $('.slide-container').has('iframe').length isnt 0
        setCurrentGameId("true")
        setCurrentSlideId(11)

        setCurrentSlideType(true)
        setCurrentIntegratedGameId($('.active').find('iframe').attr('integrated-game-id'))
        setTimeout(()->
          triggerInitGame()
        ,500)
      else
        setCurrentGameId("false")
        setCurrentSlideType(false)
      setComplete()
      setTime(getTime())
      callStartAttempt(true)
      startTime()
      nextItem.find('.center-panel').first().show()
      nextItem.show()
      return

  ,100)



Template.storyWrapper.rendered = () ->
  setCurrentIntegratedGameId('HgfmdZ4J2xZFcGwPq')

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
    markModuleAsComplete(deckId,Meteor.userId(),tenantId,"true")


    setCurrentDeckId(deckId)
    initDeck()
    Blaze.renderWithData(Template.homePage,{deckId:deckId},document.getElementsByClassName("projector")[0])
