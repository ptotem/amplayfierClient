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





@setCurrentDeckId = (deckId)->
	console.log "setting deckId...."
	console.log deckId

	@currentDeckId = deckId

@setVariantToShow = (vname)->
	@variantToShow = vname

@setCurrentSlideId = (templateId)->
	console.log "setting templateId...."
	console.log templateId

	@currentTemplateId = templateId

@setCurrentPanelId = (panelId)->
	console.log "setting templateId...."
	console.log panelId

	@currentPanelId = panelId

@setVariantName = (variantName)->
	@currentVariant = variantName

@setCurrentSlideType = (type)->
	@currentSlideType = true

@callStartAttempt = (type)->
	if type is false
		startAttempt()


@getQuestionsFromBank = (integratedGameId)->
	console.log integratedGameId
	gameData.findOne({igId:integratedGameId}).questions

@triggerInitGame = ()->
	document.getElementsByTagName('iframe')[0].contentWindow.$("body").trigger("loadGame");

@getImageInGame = ()->
	console.log "getImageInGame"
	403

@getTextInGame = (a,k)->
	console.log k
	# 403
	if customizationDecks.findOne({intGameId:currentIntegratedGameId,custKey:k})?
		customizationDecks.findOne({intGameId:currentIntegratedGameId,custKey:k}).custVal
	else
		403

@setCurrentSlideScore = (minTime, maxTime, points) ->
  if parseInt(attempt.timtTaken/1000) > minTime
    score = points
  else
    score = 0
  Session.set("currentSlideScore", 0)
  score

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
