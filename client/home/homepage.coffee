# Template.homePage.rendered  = ->
# 	setTimeout(()->
# 		console.log "grg"
# 		$('.slide-container').first().show()
#
# 		$('.slide-container').first().find('.center-panel').first().show()
# 		$('.slide-container').first().addClass 'active'
# 		$('.next-slide').on 'click', (e) ->
# 		  nextItem = $('.active').next()
# 		  $('.active').hide()
# 		  $('.active').removeClass 'active'
# 		  nextItem.show()
# 		  nextItem.find('.center-panel').first().show()
# 		  nextItem.addClass 'active'
# 		  return
# 		$('.prev-slide').on 'click', (e) ->
# 		  nextItem = $('.active').prev()
# 		  $('.active').hide()
# 		  $('.active').removeClass 'active'
# 		  nextItem.show()
# 		  nextItem.addClass 'active'
# 		  nextItem.find('.center-panel').first().show()
# 		  nextItem.show()
# 		  return
#
# 	,3000)

Template.deckList.rendered  = ->
	if !Meteor.userId()
		window.location = "/login"


Template.homePage.helpers
	getHtmlContent: () ->
		if deckHtml.findOne()?
#<<<<<<< HEAD
#			find = '/cfs';
#			re = new RegExp(find, 'g');
#			# deckHtml.findOne('AdmkhjDGiqM9Kw3Y4').htmlContent
#			deckHtml.findOne({deckId:currentDeckId}).htmlContent.replace(re,"http://lvh.me:3000/cfs")
#=======
      find = '/cfs';
      re = new RegExp(find, 'g');

#      deckHtml.findOne({deckId:currentDeckId}).htmlContent.replace(re,"http://lvh.me:3000/cfs")
      deckHtml.findOne({deckId:currentDeckId}).htmlContent.replace(re,"http://lvh.me:3000/cfs")




#>>>>>>> demodep




Template.deckList.helpers
	deckInPlatform: () ->
		deckHtml.find().fetch()

# Template.deckList.events
# 	'click .goToDeck': (e) ->
# 		window.location '/deckI'
