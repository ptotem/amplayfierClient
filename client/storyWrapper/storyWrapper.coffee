@initDeck = ()->
  setTimeout(()->
  	console.log "grg"
  	$('.slide-container').first().show()

  	$('.slide-container').first().find('.center-panel').first().show()
  	$('.slide-container').first().addClass 'active'
  	$('.next-slide').on 'click', (e) ->
  	  nextItem = $('.active').next()
  	  $('.active').hide()
  	  $('.active').removeClass 'active'
  	  nextItem.show()
  	  nextItem.find('.center-panel').first().show()
  	  nextItem.addClass 'active'
  	  return
  	$('.prev-slide').on 'click', (e) ->
  	  nextItem = $('.active').prev()
  	  $('.active').hide()
  	  $('.active').removeClass 'active'
  	  nextItem.show()
  	  nextItem.addClass 'active'
  	  nextItem.find('.center-panel').first().show()
  	  nextItem.show()
  	  return

  ,3000)



Template.storyWrapper.rendered = () ->

  console.log platforms.findOne('T5YDbhsrzpjwgFB6n').nodes
  if platforms.findOne('T5YDbhsrzpjwgFB6n')?
    window.platformData.nodes = platforms.findOne('T5YDbhsrzpjwgFB6n').nodes
    find = '/assets';
    re = new RegExp(find, 'g');
    s = platforms.findOne('T5YDbhsrzpjwgFB6n').storyConfig.replace(re,"http://192.168.0.104:3000/assets")

    window.storyConfig = JSON.parse(s);
    window.wrapperDecks = deckHtml.find().fetch()
    initPage()

Template.storyWrapper.events
  'click .zone-deck':(e)->
    initDeck()
    Blaze.renderWithData(Template.homePage,{},document.getElementsByClassName("projector")[0])
