
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
    $('.slide-container.active').find('iframe')[0].contentWindow.$("body").trigger("loadGame")
    # $($('.slide-container.active').find('iframe')[0].contentWindow.document).find('body').trigger("loadGame")
    console.log "triggerInitGame"
  # ,500)


# f = document.getElementsByTagName('iFrame')[0].contentWindow;
# f.$("body").trigger("loadGame")
# true


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
