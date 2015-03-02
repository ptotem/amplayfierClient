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

      setCurrentSlideType("false")
      setCurrentIntegratedGameId($('.active').find('iframe').attr('integrated-game-id'))
      setTimeout(()->
        triggerInitGame()
      ,500)
    else
      setCurrentGameId("false")
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

        setCurrentSlideType("true")
        setCurrentIntegratedGameId($('.active').find('iframe').attr('integrated-game-id'))
        setTimeout(()->
          triggerInitGame()
        ,500)
      else
        setCurrentGameId("false")
      callStartAttempt(true)
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
        # setCurrentSlideId(11)

        setCurrentSlideType("true")
        setCurrentIntegratedGameId($('.active').find('iframe').attr('integrated-game-id'))
        setTimeout(()->
          triggerInitGame()
        ,500)
      else
        setCurrentGameId("false")
      callStartAttempt(true)
      nextItem.find('.center-panel').first().show()
      nextItem.show()
      return

  ,100)



Template.storyWrapper.rendered = () ->
  for d in _.compact(deckHtml.find({deckId:"7sqTAiXP2kW4cACTb"}).fetch())
    console.log d._id
    window.userdata["decks"].push({deckId:d._id,complete:isModuleComplete(d._id,Meteor.userId())})

  setCurrentIntegratedGameId('HgfmdZ4J2xZFcGwPq')

  console.log platforms.findOne().nodes
  if platforms.findOne()?
    window.platformData.nodes = platforms.findOne().nodes
    # find = /^\/(^)\/storyWrapper/';
    # re = new RegExp(find, 'g');
    s = platforms.findOne().storyConfig

    window.storyConfig = JSON.parse(s);
    window.storyConfig.imgsrc = "http://amplayfier.com" + window.storyConfig.imgsrc
    window.wrapperDecks = deckHtml.find().fetch()
    initPage()

Template.storyWrapper.events
  'click .zone-deck':(e)->
    deckId = $(e.currentTarget).attr("id").split("-")[2]
    window.userdata["decks"] = []
    for d in _.compact(deckHtml.find({deckId:deckId}).fetch())
      window.userdata["decks"].push({deckId:d._id,complete:isModuleComplete(d._id,Meteor.userId())})
    markModuleAsComplete(deckId,Meteor.userId(),tenantId,"true")


    setCurrentDeckId(deckId)
    initDeck()
    Blaze.renderWithData(Template.homePage,{deckId:deckId},document.getElementsByClassName("projector")[0])
