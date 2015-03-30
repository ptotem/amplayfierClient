
@searchBar = (searchVal,targetDiv)->
  jQuery.expr[":"].contains = jQuery.expr.createPseudo((arg) ->
    (elem) ->
      jQuery(elem).text().toUpperCase().indexOf(arg.toUpperCase()) >= 0
  )
  srch = searchVal
  $(targetDiv).hide()
  $(targetDiv+":contains(" + srch + ")").show()



@dep = new Deps.Dependency;

@setPlatform = (pname)->
	@platformName = pname

@setCurrentGameId = (id)->
	@currentGameId = id

@setCurrentIntegratedGameId = (id)->
	@currentIntegratedGameId = id
	@currentIntegratedGame = id



@setTitle = (t)->
    document.title = t  ;


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

@getQuestionsFromBank = (integratedGameId)->
  gameData.findOne({igId:integratedGameId}).questions

@triggerInitGame = ()->

  $('.slide-container.active').find('iframe')[0].contentWindow.$("body").trigger("loadGame")
#  document.getElementsByTagName('iframe')[0].contentWindow.$("body").trigger("loadGame");

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
  maxTime = 1
  console.log attempt
  attr = reports.findOne({_id : attempt})
  if parseInt(attr.time/1000) > maxTime
    score = points
    scorePercentage = 100
    setScore(score)
  else
    score = parseInt(attr.time/1000)*points/maxTime
    scorePercentage = parseInt(attr.time/1000)*100/maxTime

    setScore(score)
  console.log scorePercentage
  reports.update({_id:attempt},{$set:scorePercentage:scorePercentage})
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




@faq  = [{index:1,question:"This is  question 1",answer:'This is the answer to the question 1'},{index:2,question:"This is  question 2",answer:'This is the answer to the question 2'},{index:3,question:"This is  question 3",answer:'This is the answer to the question 3'}]