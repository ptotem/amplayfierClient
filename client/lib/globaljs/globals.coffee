
@searchBar = (searchVal,targetDiv)->
  jQuery.expr[":"].contains = jQuery.expr.createPseudo((arg) ->
    (elem) ->
      jQuery(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0
  )
  srch = searchVal
  $(targetDiv).hide()
  $(targetDiv+":contains(" + srch + ")").show()



@dep = new Deps.Dependency;


@setAssessmentId = (aid)->
  @assessmentId = aid

@setManagerId = (mid)->
  @managerId = mid

@setPlatform = (pname)->
	@platformName = pname

@sideWrapperEnable = (platform)->
  if platform is 'mainPlatform'
    Session.set('subPlatformMenuBar',true)
  else
    Session.set('subPlatformMenuBar',false)


@setSubTenantId = (subTenantId)->
  @subTenantId = subTenantId

@setCurrentGameId = (id)->
	@currentGameId = id

@setCurrentIntegratedGameId = (id)->
	@currentIntegratedGameId = id
	@currentIntegratedGame = id

@setGameMaxPoints = (pts)->
  @gameMaxPoints = pts

@setTitle = (t)->
    document.title = t  ;
    $('head').append('<link rel="icon" sizes="16x16 32x32" href="/assets/images/pepsiicon-favicon.ico?v=2">')

@setCurrentDeckId = (deckId)->
	@currentDeckId = deckId

@setVariantToShow = (vname)->
	@variantToShow = vname

@setCurrentSlideId = (templateId)->

	@currentTemplateId = templateId

@setCurrentPanelId = (panelId)->
	@currentPanelId = panelId

@setVariantName = (variantName)->
	@currentVariant = variantName

@setCurrentSlideType = (type)->
	@currentSlideType = type

@callStartAttempt = (type)->
	if type is false
		startAttempt()


@setDeckId = (did)->
  @currentDisplayedDeckId = did
@getQuestionsForGame = ()->
  platforms.findOne().questions
@setUserScoreFromPlatformGame = (scr)->
  Meteor.call('setUserScoreFromGame',Meteor.userId(),scr)
@setUserCurrencyFromPlatformGame = (scr)->
  Meteor.call('setUserCurrencyFromGame',Meteor.userId(),scr)

@getQuestionsFromBank = (integratedGameId)->
  gameData.findOne({platformId:platforms.findOne()._id,igId:integratedGameId}).questions

@triggerInitGame = ()->

  # setTimeout(()->
    $('.owl-item.active').find('iframe')[0].contentWindow.$("body").trigger("loadGame")
    # $($('.slide-container.active').find('iframe')[0].contentWindow.document).find('body').trigger("loadGame")
    console.log "triggerInitGame"
  # ,500)


# f = document.getElementsByTagName('iFrame')[0].contentWindow;
# f.$("body").trigger("loadGame")
# true

@getThemePath = () ->
  Meteor.settings.public.mainLink + platforms.findOne().wrapperJson.imgsrc
@getImageInGame = (a,k)->

  # 403
  if customizationDecks.findOne({intGameId:currentIntegratedGameId,custKey:k})?
    customizationDecks.findOne({intGameId:currentIntegratedGameId,custKey:k}).custVal
  else
    403


@getTextInGame = (a,k)->

	# 403
	if customizationDecks.findOne({intGameId:currentIntegratedGameId,custKey:k})?
		customizationDecks.findOne({intGameId:currentIntegratedGameId,custKey:k}).custVal
	else
		403

@setCurrentSlideScore = (minTime, maxTime, points) ->
  maxTime = 4
  attr = reports.findOne({_id : attempt})
  slideTime = parseInt(attr.time/1000);
  if parseInt(attr.time/1000) > maxTime
    score = points
    scorePercentage = 100
#    setScore(score)
  else
    score = parseInt(attr.time/1000)*points/maxTime
    scorePercentage = parseInt(attr.time/1000)*100/maxTime

#    setScore(score)

  reports.update({_id:attempt},{$push:{slideData:{slideId:currentTemplateId,panelId:currentPanelId,slideScore:score,slideTime:slideTime,slideMaxTime:maxTime,slideMinTime:minTime,slidePoints:points,percentageScore:scorePercentage}}})
  Session.set("currentSlideScore", 0)
  true


@setPanel = (panelId, points) ->
  @currentPanel = setPanelReport(panelId, parseInt(points))


@setPanelScore = (points,minTime) ->
	if currentPanel?
		calculatedTimeSpent = new Date().getTime() - currentPanel.createdAt
		pt = 0
		if calculatedTimeSpent > minTime
			pt = points
			currentPanel.update({score: points, timeTaken: calculatedTimeSpent})
			currentPanel = null
		else
			pt = 0
			currentPanel.update({score: 0, timeTaken: calculatedTimeSpent})
			currentPanel = null
			score = Session.get("currentSlideScore")
			score = score + parseInt(pt)
			Session.set("currentSlideScore", score)

@setPanelData = (panelId, minTime, points) ->
  # setPanelScore(points, minTime)
  setPanel(panelId)




#@faq  = [{index:1,question:"This is  question 1",answer:'This is the answer to the question 1'},{index:2,question:"This is  question 2",answer:'This is the answer to the question 2'},{index:3,question:"This is  question 3",answer:'This is the answer to the question 3'}]
@faq=[{index:1,question:"What do I have to do here?",answer:'You have been invited by the administrator to engage and learn on the portal. You can view each chapter by clicking on the highlighted point in your interface. You can also view and read through the available decks within each chapter. Lastly, you can also play the games that are available to you.'},{index:2,question:"What are chapters?",answer:'Chapters are the various modules that you will have to go through in this portal. You can access a chapter by clicking on the active icon available in your interface. You can also view chapters that you have already covered. Some chapters may be unlocked as you progress through the learning.'},{index:3,question:"What are decks?",answer:'Decks are interactive presentations that you can go through to understand the various topics and concepts that you have to learn. Make sure you go through every deck in detail as these get you valuable points.'},{index:4,question:"What are games?",answer:'The games you encounter on the portal allow you to sharpen and understand what you have learnt. Games give you additional points that push up your position in the Leaderboard.'},{index:5,question:"What can I do in my dashboard?",answer:'Your dashboard acts as a central hub for all non learning activities that you can perform on the portal. You can check out the Leaderboard and chat with fellow portal players. You can also buy rewards from the reward center with the credits you have earned. Lastly you can view your profile and the badges you have received.'},{index:6,question:"What are points?",answer:'Points are the your score on the portal. The number of points you have determine your position on the Leaderboard.'},{index:7,question:"How do I get points?",answer:'You can earn points by completing interactive decks, chapters and games on the portal.'},{index:8,question:"What can I use points for?",answer:'Your points are used to determine your position on the Leaderboard. You could also receive certain badges based on the points you have.'},{index:9,question:"How can I get on the Leaderboard?",answer:'The leaderboard shows your current position on the portal. All players on the portal have a certain rank based on the points they have accumulated. You can get higher on the leaderboard by earning more points. You can do this by completing interactive decks, chapters and games. You can improve your ranking significantly by scoring better in the games.'},{index:10,question:"How do I chat?",answer:'You can chat with portal players by clicking on the player in the list you can see in the dashboard.'},{index:11,question:"Can I chat with anybody?",answer:'Yes, you can chat with anybody on the portal. You can chat with the Administrator in case you have any doubts regarding the portal or the content.'},{index:12,question:"How can I get a badge?",answer:'Badges are automatically awarded to you when you complete certain milestones. You can view the list of badges that are available to you and know how to earn them by hovering over them.'},{index:13,question:"What are the types of badges that I can get?",answer:'There are a number of badges that you can get for completing various tasks on the portal. Some badges even give you additional credits that you can use in the reward center. You can check out all the badges that you could win on the left of your dashboard. Hover over each badge to see how you could earn them.'},{index:14,question:"What are Rewards?",answer:'Rewards are vouchers or items that can be purchased from the reward center using credits.'},{index:15,question:"What are Credits?",answer:'Credits are the currency you receive on the portal for completing certain tasks. Credits are not points. Some tasks cannot be repeated to earn credits. For example, when you earn a badge, you could get additional credits. These credits cannot be earned again as you already have the badge.'},{index:16,question:"What is the Reward Center?",answer:'The reward center is an online store on the portal you are playing. It has all the items that you can purchase using the credits that you have earned.'},{index:17,question:"How do I get a Reward?",answer:'A reward, unlike a badge is not awarded. It has to be purchased from the reward center using accumulated credits. On purchasing a reward, you will be given a code or an e-mail id that you can e-mail to in order to claim your reward.'}]



@setGameAttempt = (a,b) ->
  true

@setQuestionAttempt = (a) ->
  true

@getUserCurrencyForGame = () ->
  Meteor.user().currency

@getGameQuestionByLevel = (gameName, level) ->
  # p = platforms.find({tenantId: tenantId})
  gameData.findOne({gameName: gameName, level: level}).questions

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

@changeSlideInCarousel = ()->
      if $('.slide-container.active').is(":first-child")
       $('.prev').hide()
      if $('.slide-container.active').is(":last-child")
        $(".next").hide()
      currentItem = $($('.owl-item.active').children()[0])
      # currentItem = $($('.owl-item.active').find('img'))
      
      startTime()
      setCurrentGameId("false")
      setCurrentSlideType(false)
      panelId = currentItem.attr('panel-id')   
      variantName = currentItem.attr('variant-name')
      templateId = currentItem.attr('template-id')
      setCurrentPanelId(panelId)
      setCurrentSlideId(templateId)
      if currentItem.find('video').get().length isnt 0
        currentItem.find('video').get(0).play()
      if currentItem.find('audio').get().length isnt 0
        currentItem.find('audio').get(0).play()
      if currentItem.attr("content-type") is "game"
        integratedGameId = currentItem.attr('integrated-game-id')
        setCurrentIntegratedGameId(integratedGameId)
        setGameMaxPoints(currentItem.attr('maxPoints'))
        setCurrentSlideId(1)
        triggerInitGame()




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
      if $(this).find('video').get().length isnt 0
        $(this).find('video').get(0).play()
      if $(this).find('audio').get().length isnt 0
        $(this).find('audio').get(0).play()



      executeInteractions(panelId)
      setVariantName(variantName)
    )
    item.addClass 'active'

    if parseInt(item.has('iframe').length) isnt 0
      integratedGameId = $('.active').find('iframe').attr('integrated-game-id')
      setCurrentIntegratedGameId(integratedGameId)
      setGameMaxPoints($('.active').find('iframe').attr('maxPoints'))
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

  $('.slide-container.active:visible').fadeOut('slow',(e)->
    setTime(getTime())
    minTime = $($(this).find(".center-panel")).find(".slide-wrapper").attr("min-time")
    maxTime = $($(this).find(".center-panel")).find(".slide-wrapper").attr("max-time")
    points = $($(this).find(".center-panel")).find(".slide-wrapper").attr("points")
    Session.set("currentSlideScore",points)
    setCurrentSlideScore(minTime, maxTime, Session.get("currentSlideScore"))
    if $(this).find('video').get().length isnt 0
      $(this).find('video').get(0).pause()
    if $(this).find('audio').get().length isnt 0
      $(this).find('audio').get(0).pause()


#        console.log $($(this).find(".center-panel")).attr('template-id')
  )
@changeCarouselSlide = ()->
    setTime(getTime())
    minTime = 3
    maxTime = 21
    points = 5
    Session.set("currentSlideScore",points)
    setCurrentSlideScore(minTime, maxTime, Session.get("currentSlideScore"))
    if $(this).find('video').get().length isnt 0
      $(this).find('video').get(0).pause()
    if $(this).find('audio').get().length isnt 0
      $(this).find('audio').get(0).pause()

@getThemeImagePath = ()->
  p = platforms.findOne({}).wrapperJson.themekey
  console.log p
  a = "assets/img/"+ p 
  a = a + "/"
@initDeck = ()->


  setTimeout(()->
    readHTML()
    for v in document.getElementsByTagName('video')
      v.pause()
    for v in document.getElementsByTagName('audio')
      v.pause()

    setTimeout(()->
      startAttempt($(".slide-container").length)
      changeSlideInCarousel()
    
    ,2000)
    

    # $(".center-panel[has-data='false']").remove()
    # $(".slide-container:empty").remove()
    # executeSlideLoad($('.slide-container').first())
    owl = $('.owl-carousel')
    owl.on('translated.owl.carousel',(e)->
      console.log "translated"
      changeCarouselSlide()
      changeSlideInCarousel()
      
    ) 
    # owl.on('dragged.owl.carousel',(e)->
    #   console.log "dragged"
    #   changeCarouselSlide()
    #   changeSlideInCarousel()
      
    # )
    # $('.owl-next').on 'click', (e) ->
    #   # $(".owl-carousel .owl-next").trigger('click');
    #   console.log "sass"
    #   changeCarouselSlide()
    #   changeSlideInCarousel()
      
    #   # changeCarouselSlide()
    #   # nextItem = $('.active').next()
    #   # transitionSlide()
    #   # $('.active').removeClass 'active'
    #   # executeSlideLoad(nextItem)

    # $('.owl-prev').on 'click', (e) ->
    #   # $(".owl-carousel .owl-prev").trigger('click');
    #   changeCarouselSlide()
    #   changeSlideInCarousel()
      
      # changeCarouselSlide()
      # prevItem = $('.active').prev()
      # transitionSlide()
      # $('.active').removeClass 'active'
      # executeSlideLoad(prevItem)


  ,100)

