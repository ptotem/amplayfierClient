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
    $('.next-slide').on 'click', (e) ->
      nextItem = $('.active').next()
      console.log nextItem
      $('.active').hide()
      $('.active').removeClass 'active'
      nextItem.show()
      nextItem.find('.center-panel').first().show()
      executeInteractions(nextItem.find('.slide-wrapper').attr('panel-id'))

      nextItem.addClass 'active'
      return
    $('.prev-slide').on 'click', (e) ->
      nextItem = $('.active').prev()
      $('.active').hide()
      $('.active').removeClass 'active'
      nextItem.show()
      executeInteractions(nextItem.find('.slide-wrapper').attr('panel-id'))
      nextItem.addClass 'active'
      nextItem.find('.center-panel').first().show()
      nextItem.show()
      return

  ,100)



Template.storyWrapper.rendered = () ->


  console.log platforms.findOne().nodes
  if platforms.findOne()?
    window.platformData.nodes = platforms.findOne().nodes
    find = '/assets';
    re = new RegExp(find, 'g');
    s = platforms.findOne().storyConfig.replace(re,"http://192.168.0.125:3000/assets")

    window.storyConfig = JSON.parse(s);
    window.wrapperDecks = deckHtml.find().fetch()
    initPage()

Template.storyWrapper.events
  'click .zone-deck':(e)->
    deckId = $(e.currentTarget).attr("id").split("-")[2]
    initDeck()
    Blaze.renderWithData(Template.homePage,{deckId:deckId},document.getElementsByClassName("projector")[0])
