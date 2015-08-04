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
	      find = '/cfs';
	      re = new RegExp(find, 'g');
	      # x = deckHtml.findOne({deckId:currentDeckId}).htmlContent
	      # console.log x.replace(re,Meteor.settings.public.mainLink+"/cfs")
	      # console.log currentDeckId
		  # console.log(x);
	      deckHtml.findOne({deckId:currentDeckId}).htmlContent.replace(re,Meteor.settings.public.mainLink+"/cfs");
	      # return deckHtml.findOne({deckId:currentDeckId}).htmlContent





Template.homePage.rendered = ->
	$('.component').css({"position":"relative"})
	$('.component').css({"margin":"0 auto"})
  # $('iframe').css({"height":"626px"})
  # $('iframe').css({"width":"747px"})



Template.deckList.helpers
	deckInPlatform: () ->
		deckHtml.find().fetch()

# Template.deckList.events
# 	'click .goToDeck': (e) ->
# 		window.location '/deckI'
Template.previewPPT.rendered = ->
  console.log "wrapperJson WrapperJson " + platforms.findOne().wrapperJson
	setTimeout(()->

		x = {
			center: true,
			nav:true,
			navText:['<i class=" fa fa-angle-left">','<i class=" fa fa-angle-right">']
			dots:false,
			items: 1,
			onTranslated:()->
				console.log "transa"
		}
		$('.owl-carousel').owlCarousel x
		if $('.owl-item').length is 1
			$('.owl-controls').hide()


	,1000)



Template.previewPPT.events
	'click .close-ppt-modal': () ->
		changeCarouselSlide()

		setTimeout(()->
			endAttempt()
		,2000)


		$('.projection').remove();
		$('.story-zone-playbar').remove();
		$("#carousel-viewPPT").find('iframe').remove()
		cancelFullScreen("#viewPPTModal")


Template.previewPPT.helpers
	ismodal:()->
		platforms.findOne().wrapperJson.isModal

	staticModal:()->
		if platforms.findOne().wrapperJson.isModal?
			if platforms.findOne().wrapperJson.isModal is "TRUE"
				"static"
			else
				""

	staticFalse:()->
		if platforms.findOne().wrapperJson.isModal?
			if platforms.findOne().wrapperJson.isModal is "TRUE"
				"false"
			else
				""


	deckImages: (did) ->
		deckHtml.findOne({deckId:did}).dimages

	getImgFromCreator:(link)->
		Meteor.settings.public.mainLink + link
